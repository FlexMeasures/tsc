# Notes FlexMeasures TSC 29 March 2023

## Attendees
- FlexMeasures TSC
  - Nicolas Höning
  - Felix Claessen
- External
  - Egbert Bouwhuis
  - Pierluigi Ianovale
  - Anirudh Ramesh
  - Guus Linzel
 
## Notes
- We now moved to talk about ideas in Github discussions, so everyone can take part.
- The new scheduling features were discussed briefly. The latter three see action at this point already!

## Comments and questions about the scheduling features
### Anirudh
Indian market works differently, keywords: off-grid, emerging markets.
They experimented with FM for 1-2 months, and looks like a good candidate for their tech stack (batteries).
1. prices for individual solar/wind plants can be very different
2. need to be able to set a specific (dis)charge profile for batteries

### Pierluigi
Interested in Power-2-Gas (hydrogen). In a brief discussion, we realized that FlexMeasures should already be able to capture this use case with its current StorageScheduler.
Post-meeting note: This works by setting power constraints such that the storage works in one direction (power consumption only), setting the roundtrip efficiency to the square of the conversion efficiency, and setting SoC targets equal to the expected future gas demand.

### Egbert
Q: Where is S2 used?
A: We are using it in a Dutch project, and are aware of a European R&D project using it (RESONANCE). It is a relatively new standard, presented at FLEXCON 2022, and not yet widely adopted.




