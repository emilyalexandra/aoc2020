import std.algorithm;
import std.array;
import std.conv;
import std.file;
import std.stdio;
import std.string;

struct Queue(int SIZE) {
	int[SIZE] arr;
	int start = 0, end = 0;

	@property int length() {
		if (end < start) {
			return SIZE + end - start;
		}
		return end - start;
	}

	int pop() {
		int ret = arr[start];
		start++;
		if (start >= SIZE) {
			start = 0;
		}
		return ret;
	}

	void push(int[] inArr) {
		foreach (int i; inArr) {
			arr[end] = i;
			end++;
			if (end >= SIZE) {
				end = 0;
			}
		}
	}
}

void main() {
	string input = cast(string) read("../input.txt");
	string[] players = input.split("\n\n");
	Queue!51 p1, p2;
	p1.push(players[0].split("\n")[1..$].map!(to!int).array);
	p2.push(players[1].split("\n")[1..$ - 1].map!(to!int).array);
	//p1.push([9, 2, 6, 3, 1]);
	//p2.push([5, 8, 4, 7, 10]);
	while (p1.length > 0 && p2.length > 0) {
		int c1 = p1.pop();
		int c2 = p2.pop();
		if (c1 > c2) {
			p1.push([c1, c2]);
		} else {
			p2.push([c2, c1]);
		}
	}
	if (p1.length == 0) {
		p1 = p2;
	}
	ulong mult = 1;
	ulong total;
	while (p1.length > 0) {
		int i = p1.pop();
		total += (p1.length + 1) * i;
	}
	writeln(total);
}
