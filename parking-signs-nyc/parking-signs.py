from pyproj import Proj
import pandas as pd

data = pd.read_csv('parking_regulation.csv')

p = Proj(r'+proj=lcc +lat_1=40.66666666666666 +lat_2=41.03333333333333 +lat_0=40.16666666666666 +lon_0=-74 +x_0=300000 +y_0=0 +ellps=GRS80 +datum=NAD83 +to_meter=0.3048006096012192 +no_defs') #Nad83 State Plane Ohio North US Feet Proj object using parameters

def cal_long_lat(row):
    return p(row['x'], row['y'],inverse=True)

#data['lon'], data['lat'] = zip(data.apply (lambda row: cal_long_lat (row),axis=1))
data['lon'], data['lat'] = zip(data.map(cal_long_lat))
data.head()




