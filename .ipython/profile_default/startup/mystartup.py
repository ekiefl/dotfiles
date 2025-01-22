try:
    import pandas as pd
    import numpy as np
except ImportError:
    print("Could not import pandas or numpy. Please make sure they are installed.")
else:
    # Create the DataFrame only if imports succeeded
    df = pd.DataFrame({
        'A': [1, 2, 3],
        'B': [4, 5, 6],
        'C': ['foo', 'bar', 'baz']
    }, index=['a', 'b', 'c'])
