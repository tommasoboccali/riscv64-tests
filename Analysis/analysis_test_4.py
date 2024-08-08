from plotly.subplots import make_subplots
import plotly.graph_objects as go
import pandas as pd

dfa = pd.read_csv('measure_ParFullCMS_ALL.csv_example')
#df0 = pd.read_csv('measure_AnaEx01_ALL.csv_example')
#df0 = pd.read_csv('measure_DMParticle_ALL.csv_example')

df0 = pd.read_csv('measure_NullTest_1.csv_example')
df1 = pd.read_csv('measure_ParFullCMS_1.csv_example')
df2 = pd.read_csv('measure_ParFullCMS_2.csv_example')
df4 = pd.read_csv('measure_ParFullCMS_4.csv_example')
df8 = pd.read_csv('measure_ParFullCMS_8.csv_example')
df16 = pd.read_csv('measure_ParFullCMS_16.csv_example')
df32= pd.read_csv('measure_ParFullCMS_32.csv_example')
df64= pd.read_csv('measure_ParFullCMS_64.csv_example')



fig = make_subplots(rows=1, cols=2, subplot_titles=("Full Power History", "Stacked Power History"))
fig.add_trace(
    go.Scatter(x=dfa['RUNTIME_ms'], y=dfa['POWER_W'],name="0/1/2/4/8/16/32/0 Threads"),
    row=1, col=1
)

fig.add_scatter(x=df0['RUNTIME_ms'], y=df0['POWER_W'], mode='lines', name="Baseline", row=1, col=2)
fig.add_scatter(x=df1['RUNTIME_ms'], y=df1['POWER_W'], mode='lines', name="1 Thread", row=1, col=2)
fig.add_scatter(x=df2['RUNTIME_ms'], y=df2['POWER_W'], mode='lines', name="2 Threads", row=1, col=2)
fig.add_scatter(x=df4['RUNTIME_ms'], y=df4['POWER_W'], mode='lines', name="4 Threads", row=1, col=2)
fig.add_scatter(x=df8['RUNTIME_ms'], y=df8['POWER_W'], mode='lines', name="8 Threads", row=1, col=2)
fig.add_scatter(x=df16['RUNTIME_ms'], y=df16['POWER_W'], mode='lines', name="16 Threads", row=1, col=2)
fig.add_scatter(x=df32['RUNTIME_ms'], y=df32['POWER_W'], mode='lines', name="32 Threads", row=1, col=2)
fig.add_scatter(x=df64['RUNTIME_ms'], y=df64['POWER_W'], mode='lines', name="64 Threads", row=1, col=2)

fig.update_layout(height=750, width=1500,
                  title_text="ParFullCMS Power Profile")

fig.show()


