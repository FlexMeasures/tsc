# Notes

## Attendees

FlexMeasures core team (Nicolas, Felix)
4 guests (Moise, David, Steven, Daniel)

We discussed v0.12 and the roadmap.

## Forecasting 

It was brought up by guests that forecasting support would be appreciated.
There is basic support for basic sktime models in FlexMeasures.
We should plan how to support custom forecasting models, like for scheduling.
On the other hand people could turn to OpenStef (for instance) to get dedicated forecasting support.
FlexMeasures is focused on the scheduling feature as a first-class citizen.

## Dynamic tariffs

There was a question on how dynamic tariffs are gotten for Seita's V2G living lab, and how this can work for a BRP.
Parts of this go beyond FlexMeasures capabilities, but we mentioned the flexmeasures-entsoe plugin.

## Sub-aggregation

An idea was brought up that there is a need for a "sub-aggregation" tool, which can (maybe device-agnostic) bundle a local setup,
before it is bein aggregated/optimized on a higher level (e.g. a VPP).
FlexMeasures is growing in such a direction.
One aspect here is that different kinds of flexibility need to be combined (e.g. batteries plus hot water buffers), which not many actors are offering right now.
