This scropt was created to work arround to 2-node Faiover Cluster (with witness share) problem in Windows Server (2025) 
in situation when active cluster node (with cluster IP) is shut down.
In Windows Server 2022 (and earlier) 2-nd cluster node is became activ (with cluster IP), but not in this version actually.
Also will help in deployed two Windows Server 2025 nodes and installed Exchange SE in a DAG...
https://techcommunity.microsoft.com/blog/Exchange/released-october-2025-exchange-server-security-updates/4461276

This script recommend to be scheduled with Task Scheduler 
with Security options:
"Run whether user is logged on" 
"Do not store password."
"Run with highest privileges"
 
Triggers:
Begin the task: At startup
Delay task for: 1 minute
Repeat task every: 5 minutes for duration of: Indefinitely

Maximum in 5 minuties script will run and passive node became activ... 
And in Exchange Server SE DAG all databasies became active on single server...
I hope what is temporary solution until vendor will publish real solution...
