# aind-opto-fiber-benchmark-pipeline

This pipeline processes data from the opto fiber benchmark acquisition [acquisition-link](https://github.com/AllenNeuralDynamics/FIP_DAQ_Control_IndicatorBenchmarking).

The pipeline ingests the raw data and packages it to a NWB file, running preprocessing also. Details are found below:

### Raw Data Input
```
📂 behavior_subjectID_YYYY-MM-DD_HH-M-S
├── 📂 behavior
├── 📂 behavior-videos
├── 📂 fib
├── 📄 session.json
├── 📄 subject.json
├── 📄 data_description.json
├── 📄 metadata.nd.json
├── 📄 procedures.json
├── 📄 processing.json
└── 📄 rig.json
```

The json files follow the metadata schema defined [here](https://github.com/AllenNeuralDynamics/aind-data-schema).

This pipeline specifically deals with the `session.json` and the `fib` folder. Under the `fib` folder, the relevant timeseries data are in these csv files: 
  - `Signal.csv`
  - `Iso.csv`
  - `Stim.csv`

### Opto-Fiber-Base-NWB Capsule 
This capsule INSERT CAPSULE LINK packages the raw data into a NWB file. The relevant containers 
