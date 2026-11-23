# Pass the requested diagnostic mode through the generated launcher

Tx05 passed all ten small controls and its complete receipt checks. Tx06 requested full mode, but its audit printed only ten small controls and exported the Small diagnostics theory. The runner correctly failed its expected sixteen-control gate. No full tensor checks were attempted.

Inspection of the generated transform_audit.exe shows that it launches HOL with the module name but does not forward shell arguments. CommandLine.arguments therefore did not receive the requested full argument. The installed launcher generator is unchanged.

The successor supplies the explicit C10004_TRANSFORM_MODE environment variable to the audit process. The audit accepts exactly small or full and rejects missing or unknown values. Every mathematical predicate, fixture, expected result and evaluation gate is unchanged. The reference and tests theories are unchanged. Only the audit and runner pins change in the manifest.

The original audit, launcher, runner, manifest and failed full-mode receipts remain under history/tx06_mode_dispatch. The previously exported small diagnostics artifact was verified unchanged against tx05 after tx06's re-export.

Audit SHA256: `4b4365dd574dbd514095f212d2169c13808469288095838292ee8fc32e1624ed`.
Runner SHA256: `18cef9eb215f1f1f3eadc0659aa371375ddf876580900b3d8e626e426d9442d2`.
