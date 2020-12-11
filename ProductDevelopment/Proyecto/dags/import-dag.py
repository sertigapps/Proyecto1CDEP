import codecs
import logging
from datetime import timedelta
from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from airflow.utils import dates
from airflow.models import Variable
from sqlalchemy import create_engine

logging.basicConfig(format="%(name)s-%(levelname)s-%(asctime)s-%(message)s", level=logging.INFO)
logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)
def create_dag(dag_id):
    default_args = {
        "owner": "Luis Garcia",
        "description": (
            "DAG para importar datos proporcinados a servidor de base de datos"
        ),
        "depends_on_past": False,
        "start_date": dates.days_ago(1),
        "retries": 1,
        "retry_delay": timedelta(minutes=1),
        "provide_context": True,
    }
    new_dag = DAG(
        dag_id,
        default_args=default_args,
        schedule_interval=timedelta(minutes=5),
    )
    def importarCsv(**kwargs):
        logger.info('=====Ejecutando Tarea de Importacion =============')
        logger.info('===== Archivo  =============')
        logger.info(kwargs['archivo'])
        logger.info('===== Tabla  =============')
        logger.info(kwargs['tabla'])
        host = Variable.get("127.0.0.1")
        db_name = Variable.get("db")
        username = Variable.get("user")
        password = Variable.get("PD2020GALILEO")
        connection = create_engine('mysql://{username}:{password}@{url}/{db_name}?charset=utf8'
                           .format(username=username, password=password,
                                   url=host, db_name=db_name), echo=False)
        conn = connection.connect()
        rs = conn.execute('SELECT * FROM time_series_covid19_recovered_global')
        i = 0
        for row in rs:
            i = i + 1
        data = ( { "id": 1},
                { "id": 2},
        )

        sql = "INSERT INTO " + logger.info(kwargs['tabla']) + " (id,pais, fecha, count) VALUES (%s,%s,%s, %s)"
        df = pd.read_csv ('./data/'+kwargs['archivo'])
        for index, row in df.iterrows():
            for col in df.columns: 
                if col != 'Province/State' and col != 'Country/Region' and col != 'Lat' and col != 'Long':
                    date_object = datetime.strptime(col, '%m/%d/%y')
                    val = (0,row['Country/Region'],date_object ,row[col])
                    con.execute(sql, val)
        conn.close()
        
    with new_dag:
        task1 = PythonOperator(task_id='Importar1',
                                                    python_callable=importarCsv,
                                                    op_kwargs=
                                                    {
                                                        'archivo': 'time_series_covid19_confirmed_global.csv',
                                                        'tabla': 'time_series_covid19_confirmed_global'
                                                    },
                                                    provide_context=True)
        
        task2 = PythonOperator(task_id='Importar2',
                                                    python_callable=importarCsv,
                                                    op_kwargs=
                                                    {
                                                        'archivo': 'time_series_covid19_deaths_global.csv',
                                                        'tabla': 'time_series_covid19_deaths_global'
                                                    },
                                                    provide_context=True)
        
        task3 = PythonOperator(task_id='Importar3',
                                                    python_callable=importarCsv,
                                                    op_kwargs=
                                                    {
                                                        'archivo': 'time_series_covid19_recovered_global.csv',
                                                        'tabla': 'time_series_covid19_recovered_global'
                                                    },
                                                    provide_context=True)
        task2.set_upstream(task1)
        task3.set_upstream(task2)
        return new_dag
dag_id = "import-dag"
globals()[dag_id] = create_dag(dag_id)