__author__ = 'shanky'

class CloudWatchUtils:
    @classmethod
    def get_dimension(cls, name, value):
        dimension={}
        dimension['Name']=name
        dimension['Value']=value
        return dimension

    @classmethod
    def get_metric_Data(cls, MetricName, Dimensions, Value, Unit):
        dimensions=cls.get_metric_Data_without_unit(MetricName, Dimensions, Value)
        dimensions['Unit']=Unit
        return dimensions

    @classmethod
    def get_metric_Data_without_unit(cls, MetricName, Dimensions, Value):
        dimensions={}
        dimensions['MetricName']=MetricName
        dimensions['Dimensions']=Dimensions
        dimensions['Value']=Value
        return dimensions
