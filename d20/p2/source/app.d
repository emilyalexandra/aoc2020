import std.algorithm;
import std.conv;
import std.file;
import std.stdio;
import std.string;

struct Piece {
	int id;
	uint[4] edges;
	char[8][8] content;

	Piece transform(int perm) {
		Piece p = this;
		if (perm & 0b100) {
			p.edges[1] = edges[3];
			p.edges[3] = edges[1];
			p.edges[0] = reverseMap[edges[0]];
			p.edges[2] = reverseMap[edges[2]];
			for (int i = 0; i < 8; i++) {
				p.content[i] = p.content[i].dup.reverse();
			}
		}
		for (int i = 0; i < (perm & 0b11); i++) {
			Piece lp = p;
			p.edges[0] = reverseMap[lp.edges[3]];
			p.edges[1] = lp.edges[0];
			p.edges[2] = reverseMap[lp.edges[1]];
			p.edges[3] = lp.edges[2];
			for (int x = 0; x < 8; x++) {
				for (int y = 0; y < 8; y++) {
					int nx = 7 - y;
					int ny = x;
					p.content[ny][nx] = lp.content[y][x];
				}
			}
		}
		return p;
	}
}

uint[0b11_1111_1111] reverseMap;

Piece[] pieces;

Piece[12][12] puzzle;

char[96][96] image;

string[] monster = [
"                  # ",
"#    ##    ##    ###",
" #  #  #  #  #  #   "
];

void main() {
	for (uint i = 0; i < 0b11_1111_1111; i++) {
		string s = ("0000000000" ~ i.to!string(2))[$ - 10..$];
		uint j = s.dup.reverse.to!int(2);
		reverseMap[i] = j;
	}
	string input = cast(string) read("../input.txt");
	string[] inputParts = input.split("\n\n");
	foreach (string part; inputParts) {
		string[] parts = part.split("\n");
		if (parts.length < 10) continue;
		Piece p;
		p.id = parts[0][5..$ - 1].to!int;
		for (int i = 0; i < 10; i++) {
			if (parts[1][i] == '#') p.edges[0] |= 1 << (9 - i);
			if (parts[1 + i][9] == '#') p.edges[1] |= 1 << (9 - i);
			if (parts[10][i] == '#') p.edges[2] |= 1 << (9 - i);
			if (parts[1 + i][0] == '#') p.edges[3] |= 1 << (9 - i);
		}
		for (int x = 0; x < 8; x++) {
			for (int y = 0; y < 8; y++) {
				p.content[y][x] = parts[2 + y][1 + x];
			}	
		}
		pieces ~= p;
	}
	int[int] sidePat;
	foreach (Piece p; pieces) {
		for (int i = 0; i < 4; i++) {
			if (p.edges[i] in sidePat) {
				sidePat[p.edges[i]]++;
			} else {
				sidePat[p.edges[i]] = 1;
			}
		}
	}
	Piece[] corners, sides, inner;
	foreach (Piece p; pieces) {
		int falseSides = 0;
		for (int i = 0; i < 4; i++) {
			uint e = p.edges[i];
			int t = sidePat[e];
			e = reverseMap[e]; 
			if (e in sidePat) {
				t += sidePat[e];
			}
			if (t <= 1) {
				falseSides++;
			}
		}
		if (falseSides > 0) {
			if (falseSides > 1) {
				corners ~= p;
			} else {
				sides ~= p;
			}
		} else {
			inner ~= p;
		}
	}
	Piece c = corners[0];
	corners = corners[1..$];
	while (true) {
		int conCount(uint e) {
			int t;
			if (e in sidePat) {
				t += sidePat[e];
			}
			if (reverseMap[e] in sidePat) {
				t += sidePat[reverseMap[e]];
			}
			return t;
		}
		uint e = c.edges[0];
		if (conCount(c.edges[0]) <= 1 && conCount(c.edges[3]) <= 1) break;
		c = c.transform(1);
	}
	puzzle[0][0] = c;
	for (int i = 1; i < 11; i++) {
		for (int j = 0; j < sides.length; j++) {
			int perm = canPlace(sides[j], i, 0);
			if (perm != -1) {
				puzzle[i][0] = sides[j].transform(perm);
				sides = sides[0..j] ~ sides[j + 1..$];
				break;
			}
		}
		for (int j = 0; j < sides.length; j++) {
			int perm = canPlace(sides[j], 0, i);
			if (perm != -1) {
				puzzle[0][i] = sides[j].transform(perm);
				sides = sides[0..j] ~ sides[j + 1..$];
				break;
			}
		}
	}
	for (int i = 0; i < corners.length; i++) {
		int perm = canPlace(corners[i], 11, 0);
		if (perm != -1) {
			puzzle[11][0] = corners[i].transform(perm);
			corners = corners[0..i] ~ corners[i + 1..$];
			break;
		}
	}
	for (int i = 0; i < corners.length; i++) {
		int perm = canPlace(corners[i], 0, 11);
		if (perm != -1) {
			puzzle[0][11] = corners[i].transform(perm);
			corners = corners[0..i] ~ corners[i + 1..$];
			break;
		}
	}
	for (int i = 1; i < 11; i++) {
		for (int j = 0; j < sides.length; j++) {
			int perm = canPlace(sides[j], i, 11);
			if (perm != -1) {
				puzzle[i][11] = sides[j].transform(perm);
				sides = sides[0..j] ~ sides[j + 1..$];
				break;
			}
		}
		for (int j = 0; j < sides.length; j++) {
			int perm = canPlace(sides[j], 11, i);
			if (perm != -1) {
				puzzle[11][i] = sides[j].transform(perm);
				sides = sides[0..j] ~ sides[j + 1..$];
				break;
			}
		}
	}
	int cPerm = canPlace(corners[0], 11, 11);
	puzzle[11][11] = corners[0].transform(cPerm);
	for (int x = 1; x < 11; x++) {
		for (int y = 1; y < 11; y++) {
			for (int j = 0; j < inner.length; j++) {
				int perm = canPlace(inner[j], x, y);
				if (perm != -1) {
					puzzle[x][y] = inner[j].transform(perm);
					inner = inner[0..j] ~ inner[j + 1..$];
					break;
				}
			}
		}
	}
	int roughCount;
	for (int x = 0; x < 96; x++) {
		for (int y = 0; y < 96; y++) {
			if (getPuzzleChar(0, x, y) == '#') {
				roughCount++;
			}
		}
	}
	for (int perm = 0; perm < 8; perm++) {
		for (int x = 0; x < 76; x++) {
			outer:
			for (int y = 0; y < 93; y++) {
				for (int xl = 0; xl < 20; xl++) {
					for (int yl = 0; yl < 3; yl++) {
						char ch = getPuzzleChar(perm, x + xl, y + yl);
						if (monster[yl][xl] == '#') {
							if (ch != '#'){
								continue outer;
							}
						}
					}
				}
				roughCount -= 15;
			}
		}
	}
	writeln(roughCount);
}

char getPuzzleChar(int perm, int x, int y) {
	if (perm & 0b100) {
		x = 95 - x;
	}
	for (int i = 0; i < (perm & 0b11); i++) {
		int nx = 95 - y;
		int ny = x;
		x = nx;
		y = ny;
	}
	int majX = (x & 0b1111000) >> 3;
	int majY = (y & 0b1111000) >> 3;
	int minX = x & 0b111;
	int minY = y & 0b111;
	return puzzle[majX][majY].content[minY][minX];
}

int canPlace(Piece tp, int x, int y) {
	for (int perm = 0; perm < 8; perm++) {
		Piece p = tp.transform(perm);
		if (x > 0) {
			Piece puz = puzzle[x - 1][y];
			if (puz.id != 0) {
				if (puz.edges[1] != p.edges[3]) {
					continue;
				}
			}
		}
		if (x < 9) {
			Piece puz = puzzle[x + 1][y];
			if (puz.id != 0) {
				if (puz.edges[3] != p.edges[1]) {
					continue;
				}
			}
		}
		if (y > 0) {
			Piece puz = puzzle[x][y - 1];
			if (puz.id != 0) {
				if (puz.edges[2] != p.edges[0]) {
					continue;
				}
			}
		}
		if (y < 9) {
			Piece puz = puzzle[x][y + 1];
			if (puz.id != 0) {
				if (puz.edges[0] != p.edges[1]) {
					continue;
				}
			}
		}
		return perm;
	}
	return -1;
}