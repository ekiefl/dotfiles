# essentials
import numpy as np
import pandas as pd
import os

from pandas import util

# test DataFrame to manipulate
#df = pd.DataFrame(np.arange(9).reshape((3,3)), columns=("A","B","C"), index=("a","b","c"))
df = util.testing.makeDataFrame()
df_missing = util.testing.makeMissingDataframe()
df_time = util.testing.makeTimeDataFrame()
df_mixed = util.testing.makeMixedDataFrame()

def resize():
    pd.options.display.width = 0

print("startup script: {}".format(__file__))


