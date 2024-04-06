from pyspark.sql import SparkSession

def main():
  # spark = SparkSession.builder.appName('SparkByExamplesssssssssss.com').getOrCreate()
  # spark = SparkSession.builder.master("spark://192.168.1.250:7077").appName('SparkByExamples.com').getOrCreate()
  # spark = SparkSession.builder.master("spark://192.168.1.250:7077").appName('SparkByExamples.com').config("spark.submit.deployMode", "client").getOrCreate()
  spark = SparkSession.builder.master("spark://192.168.1.250:7077").appName('SparkByExamples.com').config("spark.submit.deployMode", "cluster").getOrCreate()
  # spark = SparkSession.builder.master("spark://192.168.1.250:7077").appName('SparkByExamples.com').config("spark.submit.pyFiles", "/opt/spark-apps/main.py").getOrCreate()

  data = [("James","Smith","USA","CA"),("Michael","Rose","USA","NY"), \
      ("Robert","Williams","USA","CA"),("Maria","Jones","USA","FL") \
    ]
  columns=["firstname","lastname","country","state"]
  df=spark.createDataFrame(data=data,schema=columns)
  df.show()
if __name__ == '__main__':
  main()