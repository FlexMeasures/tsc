# Notes FlexMeasures TSC June 27, 2024

## Attendees
- FlexMeasures TSC
  - Nicolas Höning
- Others: 
  - Ard Jonker 
 
## Notes
- Presented Version 0.22 Features:
  - Bootstrap 3->5
  - Flex context (e.g. prices) as asset fields 
  - small fixes (https://github.com/FlexMeasures/flexmeasures/milestone/48?closed=1)
- Probable features for version 0.23:
  - More information on sensor page (and histogram) 
  - Speed up asset and account pages (#988)
- Roadmap to version 1.0:
  - Endpoint for multi-storage (#1065)
  - Support all energy units in the API (#1007, #386)
- Ard is interested in ability to send in sensor data (prices) in a more hands-on fashion, when automated (cron) jobs are behind and he wants his users to get schedules again. PR #563 did an investigation in uploading CSV/Excel files - what we need to discuss is authorization and there should be audit logging.   
