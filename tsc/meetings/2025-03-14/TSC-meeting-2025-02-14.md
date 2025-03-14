# TSC FlexMeasures 14 Feb 2025

## Attendees

- Nicolas Höning (Seita)
- Ragnar Edholm (Thiink)
- Ard Jonker (Positive Design)

## Topics

- Nicolas demoed flex context editing in FM 0.25
  - discussion: will API settings prevail over db settings?
- Thiink started their own plugin for weather forecasts, as OWM doesn't give history data fast enough.
  - we discussed expanding sSeita's OWM plugin, and collaborate. Thiink will send a proposal to do that
- SoC relaxation
  - Everybody likes it
  - Ragnar: Could there be an option that if a SoC can't be reached, to keep trying to reach it? Effectively relaxing the time, not the value.
- Ard asks if dealing with overlapping time series specs was implemented. 
  - Nicolas: yes, in v0.24
  - there might still be a bug
- Discussed transition to newer forecasting infrastructure (later this year). Ragnar recommends we don't support the current implementation as legacy, to avooid overhead. They will be fine.