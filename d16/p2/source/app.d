import std.algorithm;
import std.conv;
import std.file;
import std.stdio;
import std.string;

bool[int] validIds;

struct Rule {
	string name;
	int low1, high1, low2, high2;

	bool isValid(int i) {
		return (i >= low1 && i <= high1) || (i >= low2 && i <= high2);
	}
}

Rule[] ticketRules;

void main() {
	string input = cast(string) read("../input.txt");
	string[] lines = input.split("\n\n");
	string[] rules = lines[0].split("\n");
	foreach (string rule; rules) {
		string[] parts = rule.split(" or ");
		string[] sds = parts[0].split(": ");
		parts[0] = sds[1];
		int[] ints;
		foreach (string part; parts) {
			string[] sides = part.split("-");
			int low = sides[0].to!int;
			int high = sides[1].to!int;
			ints ~= low;
			ints ~= high;
			for (int i = low; i <= high; i++) {
				validIds[i] = true;
			}
		}
		ticketRules ~= Rule(sds[0], ints[0], ints[1], ints[2], ints[3]);
	}
	string[] tickets = lines[2].split("\n")[1..$];
	string[] validTickets;
	foreach (string ticket; tickets) {
		string[] nums = ticket.split(",");
		bool invalid = false;
		foreach (string num; nums) {
			int i = num.to!int;
			if (i !in validIds) {
				invalid = true;
				break;
			}
		}
		if (!invalid) {
			validTickets ~= ticket;
		}
	}
	for (int i = 0; i < ticketRules.length; i++) {
		Rule[] validRules = ticketRules.dup();
		foreach (string ticket; validTickets) {
			int[] nums = ticket.split(",").to!(int[]);
			if (nums.length <= i) continue;
			for (int j = 0; j < validRules.length; j++) {
				if (!validRules[j].isValid(nums[i])) {
					validRules = validRules[0..j] ~ validRules[j + 1..$];
					j--;
				}
			}
		}
		writeln("    ", i);
		foreach (Rule r; ticketRules) {
			if (validRules.canFind(r)) {
				writeln("1");
			} else {
				writeln("");
			}
		}
	}
	foreach (Rule r; ticketRules) {
		writeln(r.name);
	}
	// I then printed these out and solved them like I would a sudoku by pasting them into a spreadsheet
	// Yes really
}
