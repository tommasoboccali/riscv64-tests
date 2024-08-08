#
import pandas as pd
import plotly.express as px
#import plotly.graph_objects as go



df0 = pd.read_csv('measure_ParFullCMS_ALL.csv_example')


df0.head()
fig = px.line(df0, x = 'RUNTIME_ms', y = 'POWER_W', title='Power Profile', labels={'RUNTIME_ms':'Runtime (ms)', 'POWER_W':'Power (W)'})


fig.show()
