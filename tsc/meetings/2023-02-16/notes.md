# Notes

## Attendees

FlexMeasures core team (Nicolas, Felix)
 
## Scheduling
We had a deeper discussion about the scheduling roadmap: which schedulers to build in and how to expose them.

For heat optimization, we'll need a basic scheduler that can model a state of heat storage and some loss over time. There are more sophisticated algorithms possible to model some heat storages and heat sinks in more detail, but that will probably be custom implementations (or even later additions to the FlexMeasures core).

We'll split algorithms from how they are exposed.

### Currently planned algorithms

- The current storage algorithm can be expanded to be able to model simple heat storage.
- A simple shiftable algorithm can be added.
- Sector coupling within the storage scheduler (allowing heat storage as well as batteries in one site) is another extension.

### Exposing (API)

Exposing them will probably get a re-design, as we believe we are not developer-friendly enough, w.r.t. REST design and documentation.

The CLI already went the way of distinct commands per type of scheduler.

We want to focus the API more on jobs (as RESTful resource). For instance:

- POST /scheduling-job/storage: triggers a job - needs sensor ID, flex-model and context
- GET /scheduling-job/<id>: gets the schedule status
- DELETE /scheduling-job/<id>: kills a non-computed job (otherwise return 404 or fitting code)

This way, we can make the extensions we'll need later, e.g.:

- POST /scheduling-job/shifting
- POST /forecasting-job: trigger a forecasting job


## Roadmap re-priorization
Note: On https://flexmeasures.io/roadmap, when we refer to a quarter (e.g. Q1), we mean that we start work in that quarter.

We agreed to:
- move the flex-modeling to Q1 2023 (see above)
- move time series annotations to Q4 2023 (noting that work has happened on modeling it in the data, now this is about the UX for it)
- tooling to work at scale: split off the task to handle data more efficiently (Q1 2023)  
 





