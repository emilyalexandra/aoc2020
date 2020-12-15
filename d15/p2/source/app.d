import std.algorithm;
import std.conv;
import std.file;
import std.stdio;
import std.string;

int[int] lastSaid;
int[int] timesSaid;

void main() {
	int[] input = "13,16,0,12,15,1".split(",").to!(int[]);
	int turn = 0;
	foreach (int i; input) {
		lastSaid[i] = turn;
		timesSaid[i] = 1;
		turn++;
		writeln(i);
	}
	int last = input[$ - 1];
	for (; turn < 30000000; turn++) {
		int t = last;
		if (timesSaid[last] > 1) {
			last = turn - lastSaid[t] - 1;
		} else {
			last = 0;
		}
		lastSaid[t] = turn - 1;
		if (last in timesSaid) timesSaid[last]++;
		else timesSaid[last] = 1;
	}
	writeln(last);
}
