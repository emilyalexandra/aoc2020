import std.algorithm;
import std.conv;
import std.file;
import std.stdio;
import std.string;

void main() {
	string input = cast(string) read("../input.txt");
	int[] ints = input.split().to!(int[]);
	int result = getSumTwo(ints, 2020);
	writeln(result);
}

// Notes: a hash set solution would be more efficient O(n) instead of search O(n!)
int getSumTwo(int[] ints, int goal) {
	for (int i = 0; i < ints.length; i++) {
		int v1 = ints[i];
		for (int j = i + 1; j < ints.length; j++) {
			int v2 = ints[j];
			if (v1 + v2 == 2020) {
				return v1 * v2;
			}
		}
	}
	return -1;
}

unittest {
	int[] ints = [0, 2, 3, 4];
	assert(getSumTwo(ints, 4) == 0);
	assert(getSumTwo(ints, 5) == 6);
	assert(getSumTwo(ints, 6) == 8);
	assert(getSumTwo(ints, 8) == -1);
}
