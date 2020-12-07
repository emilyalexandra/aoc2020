import std.algorithm;
import std.conv;
import std.file;
import std.regex;
import std.stdio;
import std.string;

struct Bag {
	string name;
	int count;
}

auto pattern = regex(`([a-z][a-z ]+) bag`);
auto countPattern = regex(`([0-9]+) ([a-z][a-z ]+) bag`);

Bag[][string] bags;

void main() {
	string input = cast(string) read("../input.txt");
	string[] rules = input.split("\n")[0..$ - 1];
	foreach (string rule; rules) {
		string[] parts = rule.split("contain");
		string outer = matchFirst(parts[0], pattern)[1];
		Bag[] inner;
		foreach (reg; matchAll(parts[1], countPattern)) {
			if (reg[2] != "no other") {
				inner ~= Bag(reg[2], reg[1].to!int);
			}
		}
		bags[outer] = inner;
	}
	int count = 0;
	Bag[] proc = [Bag("shiny gold", 1)];
	while(proc.length > 0) {
		Bag p = proc[0];
		proc = proc[1..$];
		foreach (Bag bag; bags[p.name]) {
			bag.count *= p.count;
			proc ~= bag;
			count += bag.count;
		}
	}
	writeln(count);
}
