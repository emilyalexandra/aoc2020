import std.algorithm;
import std.array;
import std.conv;
import std.file;
import std.stdio;
import std.string;

struct Rule {
	int[][] subRules;
	char c;

	int match(string s, int id, int rec, int[int] maxRec) {
		if (s.length == 0) return -1;
		if (subRules.length == 0) {
			if (s[0] == c) {
				return 1;
			}
			return -1;
		} else {
			outer:
			foreach (int[] subRule; subRules) {
				int ret = 0;
				foreach (int sub; subRule) {
					if (sub == id && rec >= maxRec[sub]) {
						continue outer;
					}
					int i = rules[sub].match(s[ret..$], sub, sub == id ? rec + 1 : 0 , maxRec);
					if (i == -1) {
						continue outer;
					} else {
						ret += i;
					}
				}
				return ret;
			}
			return -1;
		}
	}
}

Rule[int] rules;

void main() {
	string input = cast(string) read("../input.txt");
	string[] inputParts = input.split("\n\n");
	string[] ruleInput = inputParts[0].split("\n");
	string[] lines = inputParts[1].split("\n")[0..$ - 1];
	foreach (string rule; ruleInput) {
		string[] parts = rule.split(": ");
		int id = parts[0].to!int;
		Rule r;
		if (parts[1][0] == '"') {
			r.c = parts[1][1];
		} else {
			parts = parts[1].split('|');
			r.subRules = parts.map!(p => p
				.strip
				.split(' ')
				.map!(to!int)
				.array)
			.array;
		}
		rules[id] = r;
	}
	// Part 2 rule changes
	rules[8] = Rule([[42, 8], [42]]);
	rules[11] = Rule([[42, 11, 31], [42, 31]]);
	int total;
	foreach (string line; lines) {
		for (int i = 0; i < line.length; i++) {
			for (int j = 0; j < line.length; j++) {
				int[int] maxRec = [8: i, 11: j];
				if (rules[0].match(line, 0, 0, maxRec) == line.length) {
					total++;
					break;
				}
			}
		}
	}
	writeln(total);
}
