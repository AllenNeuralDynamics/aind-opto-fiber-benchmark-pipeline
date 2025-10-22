# aind-opto-fiber-benchmark-pipeline

This [pipeline](https://codeocean.allenneuraldynamics.org/capsule/2735201/tree) processes data from the opto fiber benchmark [acquisition](https://github.com/AllenNeuralDynamics/FIP_DAQ_Control_IndicatorBenchmarking).

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

The session json contains optogenetics stimulus information. See readme link in next section for more details.

### Opto-Fiber-Base-NWB Capsule 
This [capsule](https://codeocean.allenneuraldynamics.org/capsule/4644449/tree) packages the raw data into a NWB file. The relevant containers for this NWB are the `acquisition` and `events` containers. See the [repo](https://github.com/AllenNeuralDynamics/aind-opto-fiber-benchmark-nwb-base-capsule) for more details.

The output of this capsule is shown below for the relevant containers - `acquisition` and `events`:

```
acquisition
├── Iso_0
├── Iso_1
├── Iso_2
├── Iso_3
├── Iso_4
├── Signal_0
├── Signal_1
├── Signal_2
├── Signal_3
├── Signal_4
├── Stim_0
├── Stim_1
├── Stim_2
├── Stim_3
└── Stim_4
```

```
| timestamp    | event                |
|--------------|--------------------- |
| 6.425597e+07 | OptoStimLaser_onset  |
| 6.425797e+07 | OptoStimLaser_offset |
| 6.428597e+07 | OptoStimLaser_onset  |
| 6.428797e+07 | OptoStimLaser_offset |
| 6.431598e+07 | OptoStimLaser_onset  |
| 6.431798e+07 | OptoStimLaser_offset |
| 6.434598e+07 | OptoStimLaser_onset  |
| 6.434798e+07 | OptoStimLaser_offset |
| 6.437598e+07 | OptoStimLaser_onset  |
| 6.437798e+07 | OptoStimLaser_offset |
| 6.440599e+07 | OptoStimLaser_onset  |
| 6.440799e+07 | OptoStimLaser_offset |
| 6.443598e+07 | OptoStimLaser_onset  |
| 6.443799e+07 | OptoStimLaser_offset |
| 6.446599e+07 | OptoStimLaser_onset  |
| 6.446799e+07 | OptoStimLaser_offset |
| 6.449600e+07 | OptoStimLaser_onset  |
| 6.449800e+07 | OptoStimLaser_offset |
| 6.452600e+07 | OptoStimLaser_onset  |
| 6.452800e+07 | OptoStimLaser_offset |
```

### Dff Processing
This [capsule](https://codeocean.allenneuraldynamics.org/capsule/1001867/tree) runs processing on the `acquisition` container of the NWB that gets output from the base capsule.

After processing, the NWB is updated to contain the processed data in the `processing` module. See [readme](https://github.com/AllenNeuralDynamics/aind-fip-dff) for in depth details.

### Output
The pipeline outputs the following - NWB file with the metadata files. In the NWB, the relevant containers are the `acquisition`, `events`, and `processing` modules.

```
📂 behavior_subjectID_YYYY-MM-DD_HH-M-S_processed_YYYY-MM-DD_HH-M-S
├── 📂 behavior_subjectID_YYYY-MM-DD_HH-M-S.nwb
│   ├── 📄 .zattrs
│   ├── 📄 .zgroup
│   ├── 📄 .zmetadata
│   ├── 📂 acquisition
│   ├── 📂 analysis
│   ├── 📂 events
│   ├── 📂 file_create_date
│   ├── 📂 general
│   ├── 📂 identifier
│   ├── 📂 processing
│   ├── 📂 session_description
│   ├── 📂 session_start_time
│   ├── 📂 specifications
│   ├── 📂 stimulus
│   └── 📂 timestamps_reference_time
├── 📄 data_description.json
├── 📄 output
├── 📄 procedures.json
├── 📄 processing.json
├── 📄 quality_control.json
├── 📄 rig.json
├── 📄 session.json
└── 📄 subject.json
```

