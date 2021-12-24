# essentials
import numpy as np
import pandas as pd
import os

# test DataFrame to manipulate
df = pd.DataFrame(np.arange(9).reshape((3,3)), columns=("A","B","C"), index=("a","b","c"))

def resize():
    pd.options.display.width = 0

print("startup script: {}".format(__file__))


