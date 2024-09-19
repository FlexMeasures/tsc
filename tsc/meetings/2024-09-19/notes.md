# Notes FlexMeasures TSC September 19, 2024

## Attendees
- FlexMeasures TSC
  - Nicolas Höning
- Others: 
 
## Notes
- Presented Version 0.23 features:
  - More info om sensor page
  - White-labeling
  - More expressiveness in flex-model and flex-context
  - Faster assets index page
- Probable features for version 0.24:
  - Relaxed storage scheduler & multi-commitment - Ard suggested the new scheduler returns information about imperfections (e.g. not-reached setpoints). Felix suggested the new relaxed scheduler can use its knowledge about slack variable usage for this. 
  - Data dashboard (editable, separate legends)
- Roadmap to version 1.0:
  - Endpoint for multi-storage (#1065)
  - Support all energy units in the API (#1007, #386)
  - Edit flex-context and flex-model in UI, persist on asset
