import std.algorithm;
import std.file;
import std.regex;
import std.stdio;
import std.string;

auto pattern = regex(`([a-z][a-z ]+) bag`);

string[][string] bags;

void main() {
	string input = cast(string) read("../input.txt");
	string[] rules = input.split("\n")[0..$ - 1];
	foreach (string rule; rules) {
		string[] parts = rule.split("contain");
		string outer = matchFirst(parts[0], pattern)[1];
		string[] inner;
		foreach (reg; matchAll(parts[1], pattern)) {
			if (reg[1] != "no other") {
				inner ~= reg[1];
			}
		}
		bags[outer] = inner;
	}
	int count = 0;
	foreach (string key; bags.byKey()) {
		if (key == "shiny gold") continue;
		string[] proc = [key];
		string[] processed;
		bool found = false;
		while(proc.length > 0) {
			string p = proc[0];
			if (p == "shiny gold") {
				found = true;
				break;
			}
			processed ~= p;
			proc = proc[1..$];
			foreach (string bag; bags[p]) {
				if (!proc.canFind(bag) & !processed.canFind(bag)) {
					proc ~= bag;
				}
			}
		}
		if (found) {
			count++;
		}
	}
	writeln(count);
}
