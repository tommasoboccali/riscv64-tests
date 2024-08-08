#
import pandas as pd
import plotly.express as px
#import plotly.graph_objects as go



df0 = pd.read_csv('measure_NullTest_1.csv_example')
df1 = pd.read_csv('measure_ParFullCMS_1.csv_example')
df2 = pd.read_csv('measure_ParFullCMS_2.csv_example')
df4 = pd.read_csv('measure_ParFullCMS_4.csv_example')
df8 = pd.read_csv('measure_ParFullCMS_8.csv_example')
df16 = pd.read_csv('measure_ParFullCMS_16.csv_example')
df32= pd.read_csv('measure_ParFullCMS_32.csv_example')
df64= pd.read_csv('measure_ParFullCMS_64.csv_example')

df0.head()
fig = px.line(df0, x = 'RUNTIME_ms', y = 'POWER_W', title='Power Profile', labels={'RUNTIME_ms':'Runtime (ms)', 'POWER_W':'Power (W)'})

fig.add_scatter(x=df1['RUNTIME_ms'], y=df1['POWER_W'], mode='lines', name="1 Thread")
fig.add_scatter(x=df2['RUNTIME_ms'], y=df2['POWER_W'], mode='lines', name="2 Threads")
fig.add_scatter(x=df4['RUNTIME_ms'], y=df4['POWER_W'], mode='lines', name="4 Threads")
fig.add_scatter(x=df8['RUNTIME_ms'], y=df8['POWER_W'], mode='lines', name="8 Threads")
fig.add_scatter(x=df16['RUNTIME_ms'], y=df16['POWER_W'], mode='lines', name="16 Threads")
fig.add_scatter(x=df32['RUNTIME_ms'], y=df32['POWER_W'], mode='lines', name="32 Threads")
fig.add_scatter(x=df64['RUNTIME_ms'], y=df64['POWER_W'], mode='lines', name="64 Threads")

fig.show()
