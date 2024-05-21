import numpy as np
from scipy.signal import spectrogram, savgol_filter
from scipy.signal.windows import hamming
from scipy.fft import fft, fftfreq
import pandas as pd
import h5py
from sklearn.ensemble import RandomForestRegressor
from sklearn.neural_network import MLPRegressor
from math import floor
import os

class LoadedTruckRunSet:
    
    def __init__(self, runs=[]):
        self.runs = runs
        self.inputs = pd.DataFrame()

    def train(varnames, targnames):
        trainset = self.trainset


class LoadedTruckRun:
    
    def __init__(self, timeseries=None):
        self.timeseries = timeseries

    @property
    def fft(self):
        #returns a new dataframe with an FFT of each column in timeseries

        t = self.timeseries.index.array
        fs = 1/abs(np.mean(np.diff(t)))
        freqs = fftfreq(len(t), 1/fs)
        flength = np.argwhere(np.array(freqs)>40)[0][0]
        freqs = freqs[0:flength]

        self.fft = pd.DataFrame(None, freqs, self.timeseries.columns.tolist())

        for varname, var in df.items():
            varfft = abs(fft(var.to_numpy())[:flength])
            varfft = savgol_filter(varfft, 101, 2)
            self.fft[varname] = varfft

        return self.fft
        
    def training_data(self):
        
        faz = afft(self.front.az, self.front.fs)
        fwx = afft(self.front.wx, self.front.fs)
        baz = afft(self.back.az, self.back.fs)
        bwx = afft(self.back.wx, self.back.fs)
        
        self.td = np.concatenate((faz, fwx, baz, bwx), axis=1)

        return self.td
    
    def target_data(self):
        
        targ = np.zeros((self.td.shape[0], 2))
        targ[:,0] = self.mass
        targ[:,1] = self.ix


        
        return targ
    

        
def load_from_matlab(path):

    runset = LoadedTruckRunSet()

    with h5py.File('test_data/trucksim_runs_3-28/testme.hdf5', 'r') as f:
        for rn in list(f.keys()):
    
            r = f[rn]
            rd = np.array(r)
            df = pd.DataFrame(rd[1:].T, rd[0], r.attrs['col'][1:])
            runset.runs.append(LoadedTruckRunSet(df))
            runset.inputs.append([r.attrs['mass'][0], r.attrs['cgz'][0], r.attrs['cgx'][0]])

        inputs = np.array(inputs)
    
    f.close()

        
def afft(x, fs, wtime=5, atime=30):
    #takes a sweep of FFTs in chunks of wtime the averages them over atime
    
    window = hamming(floor(wtime*fs))
    print(window.shape)
    
    affts = []
    nchunks = 2*floor(len(x)/(atime*fs))
    for i in range(0,nchunks):
        cstart = floor(atime*fs*i/2)
        cend = cstart + atime
        chunk = x[cstart:cend]
        print(chunk.shape)
        freqs, t, Sxx = spectrogram(chunk, fs=fs, window=window)
        affts.append(np.mean(Sxx, axis=1))
        
    affts = np.array(affts)
        
    return affts

def afft_s(x, fs, wtime=10):
    #takes a sweep of FFTs in chunks of wtime the averages them

    window = hamming(floor(wtime*fs))
    freqs, t, Sxx = spectrogram(x, fs=fs, window=window, noverlap = len(window) // 1.5)
    return freqs, np.mean(Sxx, axis=1)

def smooth_fft(x, fs):

    freqs = fftfreq(len(x), 1/fs)
    flength = np.argwhere(np.array(freqs)>40)[0][0]
    freqs = freqs[0:flength]

    f = abs(fft(x)[:flength])
    f = savgol_filter(f, 101, 2)

    return freqs, f

