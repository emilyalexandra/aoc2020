import std.algorithm;
import std.array;
import std.conv;
import std.file;
import std.stdio;
import std.string;

void main() {
	string input = cast(string) read("../input.txt");
	ulong[] ints = input.split("\n")[0..$ - 1].map!(l => l.to!ulong).array;
	uint i = 25;
	ulong invalid;
	while (i < ints.length) {
		if (!valid(ints[i - 25..i], ints[i])) {
			invalid = ints[i];
			break;
		}
		i++;
	}
	for (i = 0; i < ints.length; i++) {
		ulong sum = ints[i];
		ulong low = ints[i];
		ulong high = ints[i];
		for (int j = i + 1; j < ints.length; j++) {
			sum += ints[j];
			if (ints[j] < low) low = ints[j];
			if (ints[j] > high) high = ints[j];
			if (sum == invalid) {
				writeln(low + high);
			} else if (sum > invalid) {
				break;
			}
		}
	}
}

bool valid (ulong[] prev, ulong goal) {
	for (uint i = 0; i < prev.length; i++) {
		for (uint j = i + 1; j < prev.length; j++) {
			if (prev[i] + prev[j] == goal) {
				return true;
			}
		}
	}
	return false;
}
