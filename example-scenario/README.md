Example scenario
----------------

For clarity, some agreement details are omitted. Attached files *are not* valid responses/requests.

* 1: A has prepared an agreement in his system. Sends `IIA CNR` with his agreement id (`iia_id` = 0f7a5682-faf7-49a7-9cc7-ec486c49a281).
* 2: [01-A-get-response.part.xml](01-A-get-response.part.xml) - B calls the A's `IIAs get` endpoint with `iia_id` = 0f7a5682-faf7-49a7-9cc7-ec486c49a281. The response contains the hash of the cooperation conditions calculated by A.
* 3: B agrees with the version sent by A. Just to be sure, B calculates the hash of the cooperation conditions sent by A and checks that the hash sent by A was correct. Sends `IIA Approval CNR` with A's agreement id (`iia_id` = 0f7a5682-faf7-49a7-9cc7-ec486c49a281).
* 4: [02-B-approval-response.part.xml](02-B-approval-response.part.xml) - A calls B's `IIAs Approval` with `iia_id` = 0f7a5682-faf7-49a7-9cc7-ec486c49a281. Receives B's acceptance of A's version. A checks the hash to be sure that B has accepted the most current version. A can store this response as the proof that B has approved particular version of the agreement.
* 5: B has inserted the agreement in his system too. Sends `IIA CNR` with his agreement id (`iia_id` = 79364). Points 5-8 could be before 3 and 4 or mixed somehow.
* 6: [03-B-get-response.part.xml](03-B-get-response.part.xml) - A calls B's `IIAs get` endpoint with `iia_id` = 79364. The response contains the hash of the cooperation conditions calculated by B.
* 7: A agrees with the version sent by B. Just to be sure, A calculates the hash of the cooperation conditions sent by B and checks that the hash sent by B was correct. Sends `IIA Approval CNR` with B's agreement id (`iia_id` = 79364).
* [04-A-approval-response.part.xml](04-A-approval-response.part.xml) - B calls A's `IIAs Approval` with `iia_id` = 79364. Receives A's acceptance of B's version. B checks the hash to be sure that A has accepted the most current version. B can store this response as the proof that A has approved particular version of the agreement.
