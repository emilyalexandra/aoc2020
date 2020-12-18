import std.algorithm;
import std.array;
import std.conv;
import std.file;
import std.regex;
import std.stdio;
import std.string;

auto numPat = regex(`[0-9]+`);
auto opPat = regex(`(\*|\+)`);

void main() {
	string input = cast(string) read("../input.txt");
	string[] lines = input.split("\n")[0..$ - 1];
	lines.map!(l => l.solveLine)
		.fold!((a, b) => a + b)
		.writeln;
}

ulong solveLine(string line) {
	line = line.filter!(c => c != ' ').to!string;
	for (int i = 0; i < line.length; i++) {
		char c = line[i];
		if (c == '(') {
			int bal = 0;
			for (int j = i + 1; j < line.length; j++) {
				char d = line[j];
				if (d == '(') bal++;
				if (d == ')') {
					if (bal == 0) {
						ulong v = solveLine(line[i + 1..j]);
						line = line[0..i] ~ v.to!string ~ line[j + 1..$];
						break;
					}
					bal--;
				}
			}
		}
	}
	ulong[] ints;
	char[] ops;
	foreach (h; matchAll(line, numPat)) {
		ints ~= h.hit.to!ulong;
	}
	foreach (h; matchAll(line, opPat)) {
		ops ~= h.hit[0];
	}
	ulong total = ints[0];
	ints = ints[1..$];
	while (ints.length > 0) {
		if (ops[0] == '+') {
			total += ints[0];
		} else {
			total *= ints[0];
		}
		ints = ints[1..$];
		ops = ops[1..$];
	}
	return total;
}

unittest {
	assert(solveLine("1 + 2 * 3 + 4 * 5 + 6") == 71);
	assert(solveLine("1 + (2 * 3) + (4 * (5 + 6))") == 51);
}
