# FlexMeasures TSC meeting 16 July 2025

TSC: Felix Claessen, Nicolas Höning

Attending: Ard Jonker, Ragnar Edholm, Debansh Sharma


##  Discussion of testing and release policy

(showcasing and inspiration for partners' own stack)

## New release: v0.27

Main features: multi-asset scheduling, 2Fa, data upload (UI), user editing (UI)

- Q: (Devansh) Can sensors be under different assets? (Felix:) Yes, but under the same main asset (site)
- Q: (Ragnar) How about fairness in this simultanous setting? (Felix:) No, we discussed this last TSC, but not implemented yet. (Nicolas) The relevant Pyomo PR might be erged soon, though. So it could happen.
- Q: (Ard) How much validation is done on the uploaded data? (Nicolas, Felix) Sensor resolution (up/down sampling), not on unit though.

3) New situation: Higher supply prices than production

Ard tells of a new situation in NL, where Frank Energy and Zonneplan give incentives for feed-in (in exchange for curtailment on negative prices), and then supply prices might be higher than consumption prices.
FlexMeasures' optimizer cannot deal with this. Can that be improved?
(Felix): First need confirmation that this is happening, and not incidental. Not straightforward to do.
Ard will check.
