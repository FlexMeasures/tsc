# TSC FlexMeasures 30 Jan 2025

## Attendees

- Felix Claessen (Seita)
- Nicolas Höning (Seita)
- Ragnar Edholm (Thiink)
- Ard Jonker (Positive Design)

## Topics

- FM 0.25
  - flex context editing
  - multi asset  
    - prep: sequential vs simultaneous approach economic, computation time, unmet demand
    - Validated that linear optimizer handles larger number of assets well, fairness has differences
    - Question by Ragnar: will we keep the availability of using the sequential (answer: yes)
    - We have specced our multi-device flex-model PR #1065.
    - We are updating our StorageScheduler to work with multi-device flex-models.
    - We may still need a new API endpoint to trigger multi-storage scheduling on an asset containing multiple flexible devices.
    - We discussed the current results of economic and fairness research. We agreed people care about it, but it's hard to add it.
- S2 / Client
  - Talk at FOSDEM next weekend
  - in the FlexMeasures client, the S2 part will become an optional installation
  - Question by Ard: can the client give back the error messages, please (answer: yes we should prioritize this!) 
- We finally discussed Thiink's question from Slack about the peak power penalty being applied only on certain hours of the day.
        

 
