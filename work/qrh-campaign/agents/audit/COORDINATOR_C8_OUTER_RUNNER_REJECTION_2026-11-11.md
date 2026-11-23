# Outer capability runner rejected before execution

The coordinator accepts the independent review finding against
`coordinator_c8_capability_run_20261111.py`, SHA256
`32422DCD7DE763D3E806806ED2462E2D08D353949B8A2E8A4AD4858802C6C7CA`.
The prepared authorization manifest has SHA256
`9B4CDC4E4C675FE0BC254D4C3C21AB5E71D857F231ACB8CBEFE1D6D16C5756EC`.
No attempt marker, supervisor run or fixture launch was created by this runner.

Its ordinary subprocess launch does not place the supervisor in an outer job.
If the outer timeout kills the supervisor after its child is created suspended
but before the child is assigned to the inner job, that child is outside the
inner job's kill-on-close protection. The runner's cleanup comment therefore
overstates its coverage. The second communicate timeout is also uncaught, and
aggregate output acceptance was only calculated on the success path.

Do not execute this version. Preserve it as rejected preparation evidence.
A separately reviewed version must assign the supervisor to an outer job
before resuming it, contain its inherited descendants, observe termination,
and retain bounded failure evidence with aggregate output accounting. The
inner supervisor's accepted static review is unchanged. Its host capability
has not been tested, and numerical execution remains unauthorized.
