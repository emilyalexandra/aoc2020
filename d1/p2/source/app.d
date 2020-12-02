import std.algorithm;
import std.conv;
import std.file;
import std.stdio;
import std.string;

void main() {
	string input = cast(string) read("../input.txt");
	int[] ints = input.split().to!(int[]);
	int result = getSumThree(ints, 2020);
	writeln(result);
}

int getSumThree(int[] ints, int goal) {
	for (int i = 0; i < ints.length; i++) {
		int v1 = ints[i];
		for (int j = i + 1; j < ints.length; j++) {
			int v2 = ints[j];
			for (int k = j + 1; k < ints.length; k++) {
				int v3 = ints[k];
				if (v1 + v2 + v3 == goal) {
					return v1 * v2 * v3;
				}
			}
		}
	}
	return -1;
}

unittest {
	int[] ints = [0, 2, 3, 4];
	assert(getSumTwo(ints, 5) == 0);
	assert(getSumTwo(ints, 9) == 24);
	assert(getSumTwo(ints, 8) == -1);
}
