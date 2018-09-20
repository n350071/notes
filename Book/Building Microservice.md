# Building Microservice

## 1. Microservice
- Small, and Focused on Doing One Thing Well
- SRP
### key benefits
- Technology heterogeneity
- Resilience
  - bulkhead. If one component of a system fails, but that failure doesn’t cascade, you can isolate the problem and the rest of the system can carry on working.
- Scaling
- Ease of Deployment
- Organizational Alignment
- Composability
- Optimizing for Replaceability



## 2. The Evolutionary Architect
- Our requirement shift more rapidly than physical architecture.
- Not fixed points in time.
- Once launched into production, the software will continue to evolve as the way it is used changes.
## Rather than "Architect", "town planner" instead.
- The idea from Architect
  - Daiagram after diagram, page after page of documentation, created with a view to inform the construction of the PERFECT system, without taking into account the fundamentally unknowable future.
  - luck of any understanding as to how hard it will be implement, or whether or not it will actually work, let alone having any ability to change as we learn more. (プロジェクト進行中にわかったことを適用しようとも、仕様変更に耐える力がない!)
- The idea from town planner
  - city likes a living creature
  - The city changes over time.
  - we need to react and change. We cannot foresee everything that will happen, and so rather than plan for any eventuality, we should plan to allow for change by avoiding the urge to overspecify every last thing.
### Zoning
- System boundaries are important.
- Getting things wrong here leads to all sorts of problems and can be very hard to correct.

## A Principled Approach
### Strategic Goals
- you need to make sure the technology is aligned to it.
- What is the driving vision for the business? And how does it change?
Î
