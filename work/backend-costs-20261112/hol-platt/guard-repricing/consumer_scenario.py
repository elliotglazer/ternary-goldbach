"""Price alternative guarded output checkers against the already-paid split."""
from hashlib import sha256
from pathlib import Path
import json

HERE = Path(__file__).resolve().parent
HOL = HERE.parent
pins = {}


def read(path):
    contents = path.read_bytes()
    pins[str(path.relative_to(HOL))] = sha256(contents).hexdigest()
    return json.loads(contents)


def main():
    guard = read(HERE / "guard.json")["scenarios"]["640"]
    adaptive = read(HERE / "adaptive.json")
    costs = read(HOL / "small-guard-repricing/time.json")
    source = read(HOL / "small-guard-repricing/source.json")
    summary = read(HOL / "small-time-selected-consumer/integrated-summary.json")
    timing = summary["int02_bench"]["costs"]["ordinary_after_paid_split"]
    assert len(timing["values"]) == 8
    two_trials = read(HOL / "small-time-selected-consumer/two-price.json")["two01_bench"]
    assert two_trials["completed"] == 8
    two = two_trials["matched_net"]["4"]
    tiles = (35_871_686, 36_088_118)
    live = (1_775_431_871_117, 1_787_257_220_237)
    fixed_small_delta = (costs["640"]["products_hours"] - costs["0"]["products_hours"]
                         + source["640"]["character_same_length_rate_hours"] - source["0"]["character_same_length_rate_hours"]
                         + source["640"]["gaussian_hours"] - source["0"]["gaussian_hours"])
    pre = [v + fixed_small_delta + new - old for v, new, old in zip(guard["partial"], costs["640"]["split_hours"], costs["0"]["split_hours"], strict=True)]
    consumer = dict(physical_tiles=timing["tile_count_hours"]*tiles[1]/tiles[0],
                    live_samples=timing["live_count_hours"]*live[1]/live[0])
    two_consumer = dict(physical_tiles=two["tile_hours"]*tiles[1]/tiles[0],
                        live_samples=two["live_hours"]*live[1]/live[0])
    report = dict(guard=640, shape_counts=dict(physical_tiles=tiles, live_samples=live),
                  priced_before_terminal=pre, terminal_hours=consumer,
                  priced_including_three_streams={k:[x+v for x in pre] for k,v in consumer.items()},
                  two_stream_increment=two_consumer,
                  priced_including_two_streams={k:[x+v for x in pre] for k,v in two_consumer.items()},
                  alternative_grid_conditional_saving=adaptive["saving_at_existing_rates"], hashes=pins,
                  scope="Eight full physical tiles from four conductor-10000 channels. Stock HOL4 used real masks and repeated 64-position operand blocks. Both transfer models subtract matching three-stream splits. The two normalization choices are scenarios. Principal arithmetic, seed proofs, global repairs, semantic interfaces, and proof transport remain open. The prior four-channel sparse-observation rate is retained pending the independent panel.")
    (HERE / "consumer_scenario.json").write_text(json.dumps(report, indent=2) + "\n")
    print(pre, consumer, report["priced_including_three_streams"], two_consumer, report["priced_including_two_streams"])


if __name__ == "__main__":
    main()
