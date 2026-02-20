policy RC2_REPLAY_CONTROL
classify mode using indicators
when evidence.incomplete or evidence.inconsistent
set mode = MIND_MODE
emit event CLASSIFIER_INCOMPLETE
end_when
require authority.explicit when mode == MIND_MODE
enforce budget.temporal <= warrant.max_duration
on budget.exhausted -> suspend replay and open dispute
end_policy
