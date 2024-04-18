# First Load all the required library and also Start Spark Session
# Load all the required library
from pyspark.sql import SparkSession
import json
from pyspark.sql.functions import from_json, col
from pyspark.sql.types import *

#Start Spark Session
spark = SparkSession.builder.appName("chapter12") \
        .config("spark.jars.packages", "org.apache.spark:spark-sql-kafka-0-10_2.12:3.3.0")  \
        .getOrCreate()
sqlContext = SparkSession(spark)
#Dont Show warning only error
spark.sparkContext.setLogLevel("WARN")

# Schema definition for the Kafka JSON payload
customerFields = [
    StructField("id", IntegerType()),
    StructField("first_name", StringType()),
    StructField("last_name", StringType()),
    StructField("email", StringType())
]

schema = StructType([
    StructField("payload", StructType([
        StructField("before", StructType(customerFields)),
        StructField("after", StructType(customerFields)),
        StructField("ts_ms", StringType()),
        StructField("op", StringType())
    ]))
])

KAFKA_BOOTSTRAP_SERVERS = "192.168.1.250:9092"
KAFKA_TOPIC = "cdc.inventory.customers"

df = spark.readStream.format("kafka") \
    .option("kafka.bootstrap.servers", KAFKA_BOOTSTRAP_SERVERS) \
    .option("subscribe", KAFKA_TOPIC) \
    .option("startingOffsets", "earliest") \
    .load()

df
print(df)
df.printSchema()

# df.show()

# ===================== Method 1 ====================

# df.selectExpr("cast(value as string) as json") \
#     .writeStream \
#     .format("console") \
#     .outputMode("append") \
#     .start().awaitTermination()

# df.printSchema()
# df.show()


# ===================== Method 2 ====================
# Select and cast the value field to string
lines2 = df.selectExpr("CAST(value AS STRING)")

# Parse the JSON data
parsedData = lines2.select(from_json(col("value"), schema).alias("data"))

# Flatten the data and select fields
flattenedData = parsedData.select(
    col("data.payload.before.*"),
    col("data.payload.after.*"),
    col("data.payload.ts_ms"),
    col("data.payload.op")
)

streamingQuery = flattenedData \
    .writeStream \
    .format("console") \
    .outputMode("append") \
    .start()

# Start streaming
streamingQuery.awaitTermination()