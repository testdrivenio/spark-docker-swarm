try:
    from pyspark import SparkContext, SparkConf
    from operator import add
except Exception as e:
    print(e)


def get_counts():
    words = "test test"
    conf = SparkConf().setAppName('letter count')
    sc = SparkContext(conf=conf)
    seq = words.split()
    data = sc.parallelize(seq)
    counts = data.map(lambda word: (word, 1)).reduceByKey(add).collect()
    sc.stop()
    print('\n{0}\n'.format(dict(counts)))


if __name__ == "__main__":
    get_counts()
