import std.algorithm;
import std.conv;
import std.file;
import std.stdio;
import std.string;

bool[int] validIds;

void main() {
	string input = cast(string) read("../input.txt");
	string[] lines = input.split("\n\n");
	string[] rules = lines[0].split("\n");
	foreach (string rule; rules) {
		string[] parts = rule.split(" or ");
		parts[0] = parts[0].split(": ")[1];
		foreach (string part; parts) {
			string[] sides = part.split("-");
			int low = sides[0].to!int;
			int high = sides[1].to!int;
			for (int i = low; i <= high; i++) {
				validIds[i] = true;
			}
		}
	}
	int total = 0;
	string[] tickets = lines[2].split("\n")[1..$];
	foreach (string ticket; tickets) {
		string[] nums = ticket.split(",");
		foreach (string num; nums) {
			int i = num.to!int;
			if (i !in validIds) total += i;
		}
	}
	writeln(total);
}
