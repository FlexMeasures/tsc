# Notes FlexMeasures TSC August 10, 2023

## Attendees
- FlexMeasures TSC
  - Nicolas Höning
- Others: 8

 
## Notes
- Presented Version 0.15 Features (slides miss HiGHS solver
- For version 0.16, the following ideas came up:

* Documentation improvements
* More granular authentication system (ability for super-accounts to administer their customer accounts)
* Forecasting
* API modernization (OpenAPI, less legacy dependencies)
* Scheduling multiple devices: group different devices under unique constraints
* Capacity constraints as time series

No clear favorites were chosen, though.

We also discussed heating optimization in somewhat complex buildings (with inter-dependencies between heat buffers, e.g. warm water, concrete and air).

## Links from the discussion

Changelog
---------
https://github.com/FlexMeasures/flexmeasures/releases/tag/v0.15

Blog post
-----
https://flexmeasures.io/015-process-scheduling-heatmap/

Optimization model
------------------
https://flexmeasures.readthedocs.io/en/latest/concepts/device_scheduler.html

https://highs.dev/
https://github.com/coin-or/Cbc

https://flexmeasures.readthedocs.io/en/latest/plugin/introduction.html

https://git.fortiss.org/ASCI-public/memap


