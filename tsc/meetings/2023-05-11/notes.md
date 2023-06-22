# Notes FlexMeasures TSC May 11, 2023

## Attendees
- FlexMeasures TSC
  - Nicolas Höning
  - Felix Claessen
- Other
  - Victor Garcia Reolid
  - Guus Linzel
  - Ahmad Whaid

 
## Notes


### API deprecation

We presented the new policy for deprecating and sunsetting API endpoints.

Decision: Remove 4th deprecation stage (see slides).

Keep around sunset endpoints in a dedicated module (so they always return 410, and can not be accidentally redefined by developers)


### FlexMeasures Client

Sneak preview of a Python client library (open source) which can be used to talk to a FlexMeasures server.

Decisions:

- Actually make it pip installable
- Expand the Readme with a list of methods (see TSC slides), and refer to their docstrings
- Develop a full example, for the Readme and also for the FlexMeasures docs.


### Roadmap

Desire to discuss VPP capabilities, even if those features are far out.

Suggestions:

- Next TSC could talk about VPP, after the main discussions.

Until then, there are Slack groups that can be joined for anyone interested in more energy-data topics:

- Energy Data Experts Network
- New Energy Network
- DER Task Force
- and of course LF Energy

And links to VPP related events of a group in the U.S.:

- https://lu.ma/gdipbyiv
- https://lu.ma/jchdu75b




