package decompiler.tags.doabc.instruction
{
	import decompiler.tags.doabc.ABCFile;
	import decompiler.tags.doabc.instruction.jump.Abs_jump;
	import decompiler.tags.doabc.instruction.jump.Ifeq;
	import decompiler.tags.doabc.instruction.jump.Iffalse;
	import decompiler.tags.doabc.instruction.jump.Ifge;
	import decompiler.tags.doabc.instruction.jump.Ifgt;
	import decompiler.tags.doabc.instruction.jump.Ifle;
	import decompiler.tags.doabc.instruction.jump.Iflt;
	import decompiler.tags.doabc.instruction.jump.Ifne;
	import decompiler.tags.doabc.instruction.jump.Ifnge;
	import decompiler.tags.doabc.instruction.jump.Ifngt;
	import decompiler.tags.doabc.instruction.jump.Ifnle;
	import decompiler.tags.doabc.instruction.jump.Ifnlt;
	import decompiler.tags.doabc.instruction.jump.Ifstricteq;
	import decompiler.tags.doabc.instruction.jump.Ifstrictne;
	import decompiler.tags.doabc.instruction.jump.Iftrue;
	import decompiler.tags.doabc.instruction.jump.Jump;

	public final class InstructionFactory
	{
		
		
		public function InstructionFactory()
		{
		}
		
		public static function getPCodeFormByStr(str:String):int
		{
			switch(str)
			{
				case "bkpt": return 1;
				case "nop": return 2;
				case "throw": return 3;
				case "getsuper": return 4;
				case "setsuper": return 5;
				case "dxns": return 6;
				case "dxnslate": return 7;
				case "kill": return 8;
				case "label": return 9;
				case "ifnlt": return 12;
				case "ifnle": return 13;
				case "ifngt": return 14;
				case "ifnge": return 15;
				case "jump": return 16;
				case "iftrue": return 17;
				case "iffalse": return 18;
				case "ifeq": return 19;
				case "ifne": return 20;
				case "iflt": return 21;
				case "ifle": return 22;
				case "ifgt": return 23;
				case "ifge": return 24;
				case "ifstricteq": return 25;
				case "ifstrictne": return 26;
				case "lookupswitch": return 27;
				case "pushwith": return 28;
				case "popscope": return 29;
				case "nextname": return 30;
				case "hasnext": return 31;
				case "pushnull": return 32;
				case "pushundefined": return 33;
				case "pushconstant": return 34;
				case "nextvalue": return 35;
				case "pushbyte": return 36;
				case "pushshort": return 37;
				case "pushtrue": return 38;
				case "pushfalse": return 39;
				case "pushnan": return 40;
				case "pop": return 41;
				case "dup": return 42;
				case "swap": return 43;
				case "pushstring": return 44;
				case "pushint": return 45;
				case "pushuint": return 46;
				case "pushdouble": return 47;
				case "pushscope": return 48;
				case "pushnamespace": return 49;
				case "hasnext2": return 50;
				case "pushdecimal": return 51;
				case "li8": return 53;
				case "li16": return 54;
				case "li32": return 55;
				case "lf32": return 56;
				case "lf64": return 57;
				case "si8": return 58;
				case "si16": return 59;
				case "si32": return 60;
				case "sf32": return 61;
				case "sf64": return 62;
				case "newfunction": return 64;
				case "call": return 65;
				case "construct": return 66;
				case "callmethod": return 67;
				case "callstatic": return 68;
				case "callsuper": return 69;
				case "callproperty": return 70;
				case "returnvoid": return 71;
				case "returnvalue": return 72;
				case "constructsuper": return 73;
				case "constructprop": return 74;
				case "callsuperid": return 75;
				case "callproplex": return 76;
				case "callinterface": return 77;
				case "callsupervoid": return 78;
				case "callpropvoid": return 79;
				case "sxi1": return 80;
				case "sxi8": return 81;
				case "sxi16": return 82;
				case "applytype": return 83;
				case "newobject": return 85;
				case "newarray": return 86;
				case "newactivation": return 87;
				case "newclass": return 88;
				case "getdescendants": return 89;
				case "newcatch": return 90;
				case "findpropstrict": return 93;
				case "findproperty": return 94;
				case "finddef": return 95;
				case "getlex": return 96;
				case "setproperty": return 97;
				case "getlocal": return 98;
				case "setlocal": return 99;
				case "getglobalscope": return 100;
				case "getscopeobject": return 101;
				case "getproperty": return 102;
				case "getouterscope": return 103;
				case "initproperty": return 104;
				case "deleteproperty": return 106;
				case "deletepropertylate": return 107;
				case "getslot": return 108;
				case "setslot": return 109;
				case "getglobalslot": return 110;
				case "setglobalslot": return 111;
				case "convert_s": return 112;
				case "esc_xelem": return 113;
				case "esc_xattr": return 114;
				case "convert_i": return 115;
				case "convert_u": return 116;
				case "convert_d": return 117;
				case "convert_b": return 118;
				case "convert_o": return 119;
				case "checkfilter": return 120;
				case "coerce": return 128;
				case "coerce_b": return 129;
				case "coerce_a": return 130;
				case "coerce_i": return 131;
				case "coerce_d": return 132;
				case "coerce_s": return 133;
				case "astype": return 134;
				case "astypelate": return 135;
				case "coerce_u": return 136;
				case "coerce_o": return 137;
				case "negate": return 144;
				case "increment": return 145;
				case "inclocal": return 146;
				case "decrement": return 147;
				case "declocal": return 148;
				case "typeof_": return 149;
				case "not": return 150;
				case "bitnot": return 151;
				case "concat": return 154;
				case "add_d": return 155;
				case "add": return 160;
				case "subtract": return 161;
				case "multiply": return 162;
				case "divide": return 163;
				case "modulo": return 164;
				case "lshift": return 165;
				case "rshift": return 166;
				case "urshift": return 167;
				case "bitand": return 168;
				case "bitor": return 169;
				case "bitxor": return 170;
				case "equals": return 171;
				case "strictequals": return 172;
				case "lessthan": return 173;
				case "lessequals": return 174;
				case "greaterthan": return 175;
				case "greaterequals": return 176;
				case "instanceof_": return 177;
				case "istype": return 178;
				case "istypelate": return 179;
				case "in_": return 180;
				case "increment_i": return 192;
				case "decrement_i": return 193;
				case "inclocal_i": return 194;
				case "declocal_i": return 195;
				case "negate_i": return 196;
				case "add_i": return 197;
				case "subtract_i": return 198;
				case "multiply_i": return 199;
				case "getlocal_0": return 208;
				case "getlocal_1": return 209;
				case "getlocal_2": return 210;
				case "getlocal_3": return 211;
				case "setlocal_0": return 212;
				case "setlocal_1": return 213;
				case "setlocal_2": return 214;
				case "setlocal_3": return 215;
				case "debug": return 239;
				case "debugline": return 240;
				case "debugfile": return 241;
				case "bkptline": return 242;
				case "timestamp": return 243;
				case "verifypass": return 245;
				default:
					throw new Error("unknown opcode " + str);
			}
		}
		
		public static function creatInstruction(forms:uint, abcFile:ABCFile):AbstractInstruction
		{
			switch(forms)
			{
				case 1:		return abcFile.elementFactory(Bkpt) as Bkpt;//Undocumented   If in debug mode, enter the debugger. 
				case 2:		return abcFile.elementFactory(Nop) as Nop;
				case 3:		return abcFile.elementFactory(Throw) as Throw;
				case 4:		return abcFile.elementFactory(Getsuper) as Getsuper;
				case 5:		return abcFile.elementFactory(Setsuper) as Setsuper;
				case 6:		return abcFile.elementFactory(Dxns) as Dxns;
				case 7:		return abcFile.elementFactory(Dxnslate) as Dxnslate;
				case 8:		return abcFile.elementFactory(Kill) as Kill;
				case 9:		return abcFile.elementFactory(Label) as Label;
//				case 10:
//				case 11:
				case 12:	return abcFile.elementFactory(Ifnlt) as Ifnlt;
				case 13:	return abcFile.elementFactory(Ifnle) as Ifnle;
				case 14:	return abcFile.elementFactory(Ifngt) as Ifngt;
				case 15:	return abcFile.elementFactory(Ifnge) as Ifnge;
				case 16:	return abcFile.elementFactory(Jump) as Jump;
				case 17:	return abcFile.elementFactory(Iftrue) as Iftrue;
				case 18:	return abcFile.elementFactory(Iffalse) as Iffalse;
				case 19:	return abcFile.elementFactory(Ifeq) as Ifeq;
				case 20:	return abcFile.elementFactory(Ifne) as Ifne;
				case 21:	return abcFile.elementFactory(Iflt) as Iflt;
				case 22:	return abcFile.elementFactory(Ifle) as Ifle;
				case 23:	return abcFile.elementFactory(Ifgt) as Ifgt;
				case 24:	return abcFile.elementFactory(Ifge) as Ifge;
				case 25:	return abcFile.elementFactory(Ifstricteq) as Ifstricteq;
				case 26:	return abcFile.elementFactory(Ifstrictne) as Ifstrictne;
				case 27:	return abcFile.elementFactory(Lookupswitch) as Lookupswitch;
				case 28:	return abcFile.elementFactory(Pushwith) as Pushwith;
				case 29:	return abcFile.elementFactory(Popscope) as Popscope;
				case 30:	return abcFile.elementFactory(Nextname) as Nextname;
				case 31:	return abcFile.elementFactory(Hasnext) as Hasnext;
				case 32:	return abcFile.elementFactory(Pushnull) as Pushnull;
				case 33:	return abcFile.elementFactory(Pushundefined) as Pushundefined;
				case 34:	return abcFile.elementFactory(Pushconstant) as Pushconstant;//Undocumented  push constant(常数)
				case 35:	return abcFile.elementFactory(Nextvalue) as Nextvalue;
				case 36:	return abcFile.elementFactory(Pushbyte) as Pushbyte;
				case 37:	return abcFile.elementFactory(Pushshort) as Pushshort;
				case 38:	return abcFile.elementFactory(Pushtrue) as Pushtrue;
				case 39:	return abcFile.elementFactory(Pushfalse) as Pushfalse;
				case 40:	return abcFile.elementFactory(Pushnan) as Pushnan;
				case 41:	return abcFile.elementFactory(Pop) as Pop;
				case 42:	return abcFile.elementFactory(Dup) as Dup;
				case 43:	return abcFile.elementFactory(Swap) as Swap;
				case 44:	return abcFile.elementFactory(Pushstring) as Pushstring;
				case 45:	return abcFile.elementFactory(Pushint) as Pushint;
				case 46:	return abcFile.elementFactory(Pushuint) as Pushuint;
				case 47:	return abcFile.elementFactory(Pushdouble) as Pushdouble;
				case 48:	return abcFile.elementFactory(Pushscope) as Pushscope;
				case 49:	return abcFile.elementFactory(Pushnamespace) as Pushnamespace;
				case 50:	return abcFile.elementFactory(Hasnext2) as Hasnext2;
				case 51:	return abcFile.elementFactory(Pushdecimal) as Pushdecimal;//Undocumented
//				case 52:	
				case 53:	return abcFile.elementFactory(Li8) as Li8;
				case 54:	return abcFile.elementFactory(Li16) as Li16;
				case 55:	return abcFile.elementFactory(Li32) as Li32;
				case 56:	return abcFile.elementFactory(Lf32) as Lf32;
				case 57:	return abcFile.elementFactory(Lf64) as Lf64;
				case 58:	return abcFile.elementFactory(Si8) as Si8;
				case 59:	return abcFile.elementFactory(Si16) as Si16;
				case 60:	return abcFile.elementFactory(Si32) as Si32;
				case 61:	return abcFile.elementFactory(Sf32) as Sf32;
				case 62:	return abcFile.elementFactory(Sf64) as Sf64;
//				case 63:	
				case 64:	return abcFile.elementFactory(Newfunction) as Newfunction;
				case 65:	return abcFile.elementFactory(Call) as Call;
				case 66:	return abcFile.elementFactory(Construct) as Construct;
				case 67:	return abcFile.elementFactory(Callmethod) as Callmethod;
				case 68:	return abcFile.elementFactory(Callstatic) as Callstatic;
				case 69:	return abcFile.elementFactory(Callsuper) as Callsuper;
				case 70:	return abcFile.elementFactory(Callproperty) as Callproperty;
				case 71:	return abcFile.elementFactory(Returnvoid) as Returnvoid;
				case 72:	return abcFile.elementFactory(Returnvalue) as Returnvalue;
				case 73:	return abcFile.elementFactory(Constructsuper) as Constructsuper;
				case 74:	return abcFile.elementFactory(Constructprop) as Constructprop;
				case 75:	return abcFile.elementFactory(Callsuperid) as Callsuperid;//Undocumented
				case 76:	return abcFile.elementFactory(Callproplex) as Callproplex;
				case 77:	return abcFile.elementFactory(Callinterface) as Callinterface;//Undocumented
				case 78:	return abcFile.elementFactory(Callsupervoid) as Callsupervoid;
				case 79:	return abcFile.elementFactory(Callpropvoid) as Callpropvoid;
				case 80:	return abcFile.elementFactory(Sxi1) as Sxi1;
				case 81:	return abcFile.elementFactory(Sxi8) as Sxi8;
				case 82:	return abcFile.elementFactory(Sxi16) as Sxi16;
				case 83:	return abcFile.elementFactory(Applytype) as Applytype;//Undocumented
//				case 84:
				case 85:	return abcFile.elementFactory(Newobject) as Newobject;
				case 86:	return abcFile.elementFactory(Newarray) as Newarray;
				case 87:	return abcFile.elementFactory(Newactivation) as Newactivation;
				case 88:	return abcFile.elementFactory(Newclass) as Newclass;
				case 89:	return abcFile.elementFactory(Getdescendants) as Getdescendants;
				case 90:	return abcFile.elementFactory(Newcatch) as Newcatch;
				case 91:	return abcFile.elementFactory(Findpropglobalstrict) as Findpropglobalstrict;//Undocumented
				case 92:	return abcFile.elementFactory(Findpropglobal) as Findpropglobal;//Undocumented
				case 93:	return abcFile.elementFactory(Findpropstrict) as Findpropstrict;
				case 94:	return abcFile.elementFactory(Findproperty) as Findproperty;
				case 95:	return abcFile.elementFactory(Finddef) as Finddef;//Undocumented
				case 96:	return abcFile.elementFactory(Getlex) as Getlex;
				case 97:	return abcFile.elementFactory(Setproperty) as Setproperty;
				case 98:	return abcFile.elementFactory(Getlocal) as Getlocal;
				case 99:	return abcFile.elementFactory(Setlocal) as Setlocal;
				case 100:	return abcFile.elementFactory(Getglobalscope) as Getglobalscope;
				case 101:	return abcFile.elementFactory(Getscopeobject) as Getscopeobject;
				case 102:	return abcFile.elementFactory(Getproperty) as Getproperty;
				case 103:	return abcFile.elementFactory(Getouterscope) as Getouterscope;//Undocumented
				case 104:	return abcFile.elementFactory(Initproperty) as Initproperty;
				case 106:	return abcFile.elementFactory(Deleteproperty) as Deleteproperty;
				case 107:	return abcFile.elementFactory(Deletepropertylate) as Deletepropertylate;//Undocumented
				case 108:	return abcFile.elementFactory(Getslot) as Getslot;
				case 109:	return abcFile.elementFactory(Setslot) as Setslot;
				case 110:	return abcFile.elementFactory(Getglobalslot) as Getglobalslot;
				case 111:	return abcFile.elementFactory(Setglobalslot) as Setglobalslot;
				case 112:	return abcFile.elementFactory(Convert_s) as Convert_s;
				case 113:	return abcFile.elementFactory(Esc_xelem) as Esc_xelem;
				case 114:	return abcFile.elementFactory(Esc_xattr) as Esc_xattr;
				case 115:	return abcFile.elementFactory(Convert_i) as Convert_i;
				case 116:	return abcFile.elementFactory(Convert_u) as Convert_u;
				case 117:	return abcFile.elementFactory(Convert_d) as Convert_d;
				case 118:	return abcFile.elementFactory(Convert_b) as Convert_b;
				case 119:	return abcFile.elementFactory(Convert_o) as Convert_o;
				case 120:	return abcFile.elementFactory(Checkfilter) as Checkfilter;
//				case 121:
//				case 122:
//				case 123:
//				case 124:
//				case 125:
//				case 126:
//				case 127:
				case 128:	return abcFile.elementFactory(Coerce) as Coerce;
				case 129:	return abcFile.elementFactory(Coerce_b) as Coerce_b;//Undocumented
				case 130:	return abcFile.elementFactory(Coerce_a) as Coerce_a;
				case 131:	return abcFile.elementFactory(Coerce_i) as Coerce_i;//Undocumented
				case 132:	return abcFile.elementFactory(Coerce_d) as Coerce_d;//Undocumented
				case 133:	return abcFile.elementFactory(Coerce_s) as Coerce_s;
				case 134:	return abcFile.elementFactory(Astype) as Astype;
				case 135:	return abcFile.elementFactory(Astypelate) as Astypelate;
				case 136:	return abcFile.elementFactory(Coerce_u) as Coerce_u;//Undocumented
				case 137:	return abcFile.elementFactory(Coerce_o) as Coerce_o;//Undocumented
//				case 138:
//				case 139:
//				case 140:
//				case 141:
//				case 142:
//				case 143:
				case 144:	return abcFile.elementFactory(Negate) as Negate;
				case 145:	return abcFile.elementFactory(Increment) as Increment;
				case 146:	return abcFile.elementFactory(Inclocal) as Inclocal;
				case 147:	return abcFile.elementFactory(Decrement) as Decrement;
				case 148:	return abcFile.elementFactory(Declocal) as Declocal;
				case 149:	return abcFile.elementFactory(Typeof) as Typeof;
				case 150:	return abcFile.elementFactory(Not) as Not;
				case 151:	return abcFile.elementFactory(Bitnot) as Bitnot;
//				case 152:
//				case 153:
				case 154:	return abcFile.elementFactory(Concat) as Concat;//Undocumented
				case 155:	return abcFile.elementFactory(Add_d) as Add_d;
//				case 156:
//				case 157:
//				case 158:
//				case 159:
				case 160:	return abcFile.elementFactory(Add) as Add;
				case 161:	return abcFile.elementFactory(Subtract) as Subtract;
				case 162:	return abcFile.elementFactory(Multiply) as Multiply;
				case 163:	return abcFile.elementFactory(Divide) as Divide;
				case 164:	return abcFile.elementFactory(Modulo) as Modulo;
				case 165:	return abcFile.elementFactory(Lshift) as Lshift;
				case 166:	return abcFile.elementFactory(Rshift) as Rshift;
				case 167:	return abcFile.elementFactory(Urshift) as Urshift;
				case 168:	return abcFile.elementFactory(Bitand) as Bitand;
				case 169:	return abcFile.elementFactory(Bitor) as Bitor;
				case 170:	return abcFile.elementFactory(Bitxor) as Bitxor;
				case 171:	return abcFile.elementFactory(Equals) as Equals;
				case 172:	return abcFile.elementFactory(Strictequals) as Strictequals;
				case 173:	return abcFile.elementFactory(Lessthan) as Lessthan;
				case 174:	return abcFile.elementFactory(Lessequals) as Lessequals;
				case 175:	return abcFile.elementFactory(Greaterthan) as Greaterthan;
				case 176:	return abcFile.elementFactory(Greaterequals) as Greaterequals;
				case 177:	return abcFile.elementFactory(Instanceof) as Instanceof;
				case 178:	return abcFile.elementFactory(Istype) as Istype;
				case 179:	return abcFile.elementFactory(Istypelate) as Istypelate;
				case 180:	return abcFile.elementFactory(In) as In;
//				case 181:
//				case 182:
//				case 183:
//				case 184:
//				case 185:
//				case 186:
//				case 187:
//				case 188:
//				case 189:
//				case 190:
//				case 191:
				case 192:	return abcFile.elementFactory(Increment_i) as Increment_i;
				case 193:	return abcFile.elementFactory(Decrement_i) as Decrement_i;
				case 194:	return abcFile.elementFactory(Inclocal_i) as Inclocal_i;
				case 195:	return abcFile.elementFactory(Declocal_i) as Declocal_i;
				case 196:	return abcFile.elementFactory(Negate_i) as Negate_i;
				case 197:	return abcFile.elementFactory(Add_i) as Add_i;
				case 199:	return abcFile.elementFactory(Multiply_i) as Multiply_i;
				case 198:	return abcFile.elementFactory(Subtract_i) as Subtract_i;
//				case 199:
//				case 200:
//				case 201:
//				case 202:
//				case 203:
//				case 204:
//				case 205:
//				case 206:
//				case 207:
				case 208:	return abcFile.elementFactory(Getlocal_0) as Getlocal_0;
				case 209:	return abcFile.elementFactory(Getlocal_1) as Getlocal_1;
				case 210:	return abcFile.elementFactory(Getlocal_2) as Getlocal_2;
				case 211:	return abcFile.elementFactory(Getlocal_3) as Getlocal_3;
				case 212:	return abcFile.elementFactory(Setlocal_0) as Setlocal_0;
				case 213:	return abcFile.elementFactory(Setlocal_1) as Setlocal_1;
				case 214:	return abcFile.elementFactory(Setlocal_2) as Setlocal_2;
				case 215:	return abcFile.elementFactory(Setlocal_3) as Setlocal_3;
//				case 216:
//				case 217:
//				case 218:
//				case 219:
//				case 220:
//				case 221:
//				case 222:
//				case 223:
//				case 224:
//				case 225:
//				case 226:
//				case 227:
//				case 228:
//				case 229:
//				case 230:
//				case 231:
//				case 232:
//				case 233:
//				case 234:
//				case 235:
//				case 236:
//				case 237:
				case 238:	return abcFile.elementFactory(Abs_jump) as Abs_jump;
				case 239:	return abcFile.elementFactory(Debug) as Debug;
				case 240:	return abcFile.elementFactory(Debugline) as Debugline;
				case 241:	return abcFile.elementFactory(Debugfile) as Debugfile;
				case 242:	return abcFile.elementFactory(Bkptline) as Bkptline;//Undocumented
				case 243:	return abcFile.elementFactory(Timestamp) as Timestamp;//Undocumented
//				case 244:	
				case 245:	return abcFile.elementFactory(Verifypass) as Verifypass;//Undocumented
				case 246:	return abcFile.elementFactory(Alloc) as Alloc;//Undocumented
				case 247:	return abcFile.elementFactory(Mark) as Mark;//Undocumented
				case 248:	return abcFile.elementFactory(Wb) as Wb;//Undocumented
				case 249:	return abcFile.elementFactory(Prologue) as Prologue;//Undocumented
				case 250:	return abcFile.elementFactory(Sendenter) as Sendenter;//Undocumented
				case 251:	return abcFile.elementFactory(Doubletoatom) as Doubletoatom;//Undocumented
				case 252:	return abcFile.elementFactory(Sweep) as Sweep;//Undocumented
				case 253:	return abcFile.elementFactory(Codegenop) as Codegenop;//Undocumented
				case 254:	return abcFile.elementFactory(Verifyop) as Verifyop;//Undocumented
				case 255:	return abcFile.elementFactory(Decode) as Decode;//Undocumented
				default:
					throw new Error("未识别的PCode操作码:" + forms);
					break;
			}
		}
	}
}