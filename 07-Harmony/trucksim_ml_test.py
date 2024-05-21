#%%

from harmony_util import *
import numpy as np
import matplotlib.pyplot as plt
import matplotlib


folder = 'C:/Users/kyleh/Desktop/Axicle/Steve Krug - Public/15. GitHub Repo/Axicle/07-Harmony/test_data/trucksim_runs_3-27/'
ltr = load_ts_case(folder + 'run1001.csv', 0, 0)

fig, ax = plt.subplots()
ax.plot(ltr.front.t, ltr.front.az)

print(matplotlib.get_backend())
