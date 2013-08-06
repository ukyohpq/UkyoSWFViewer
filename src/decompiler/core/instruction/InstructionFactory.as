package decompiler.core.instruction
{
	public final class InstructionFactory
	{
		public function InstructionFactory()
		{
		}
		
		public static function creatInstruction(forms:uint):AbstractInstruction
		{
			switch(forms)
			{
				case 1:		return new Bkpt;//Undocumented   If in debug mode, enter the debugger. 
				case 2:		return new Nop;
				case 3:		return new Throw;
				case 4:		return new Getsuper;
				case 5:		return new Setsuper;
				case 6:		return new Dxns;
				case 7:		return new Dxnslate;
				case 8:		return new Kill;
				case 9:		return new Label;
//				case 10:
//				case 11:
				case 12:	return new Ifnlt;
				case 13:	return new Ifnle;
				case 14:	return new Ifngt;
				case 15:	return new Ifnge;
				case 16:	return new Jump;
				case 17:	return new Iftrue;
				case 18:	return new Iffalse;
				case 19:	return new Ifeq;
				case 20:	return new Ifne;
				case 21:	return new Iflt;
				case 22:	return new Ifle;
				case 23:	return new Ifgt;
				case 24:	return new Ifge;
				case 25:	return new Ifstricteq;
				case 26:	return new Ifstrictne;
				case 27:	return new Lookupswitch;
				case 28:	return new Pushwith;
				case 29:	return new Popscope;
				case 30:	return new Nextname;
				case 31:	return new Hasnext;
				case 32:	return new Pushnull;
				case 33:	return new Pushundefined;
				case 34:	return new Pushconstant;//Undocumented  push constant(常数)
				case 35:	return new Nextvalue;
				case 36:	return new Pushbyte;
				case 37:	return new Pushshort;
				case 38:	return new Pushtrue;
				case 39:	return new Pushfalse;
				case 40:	return new Pushnan;
				case 41:	return new Pop;
				case 42:	return new Dup;
				case 43:	return new Swap;
				case 44:	return new Pushstring;
				case 45:	return new Pushint;
				case 46:	return new Pushuint;
				case 47:	return new Pushdouble;
				case 48:	return new Pushscope;
				case 49:	return new Pushnamespace;
				case 50:	return new Hasnext2;
				case 51:	return new Pushdecimal;//Undocumented
//				case 52:	
				case 53:	return new Li8;
				case 54:	return new Li16;
				case 55:	return new Li32;
				case 56:	return new Lf32;
				case 57:	return new Lf64;
				case 58:	return new Si8;
				case 59:	return new Si16;
				case 60:	return new Si32;
				case 61:	return new Sf32;
				case 62:	return new Sf64;
//				case 63:	
				case 64:	return new Newfunction;
				case 65:	return new Call;
				case 66:	return new Construct;
				case 67:	return new Callmethod;
				case 68:	return new Callstatic;
				case 69:	return new Callsuper;
				case 70:	return new Callproperty;
				case 71:	return new Returnvoid;
				case 72:	return new Returnvalue;
				case 73:	return new Constructsuper;
				case 74:	return new Constructprop;
				case 75:	return new Callsuperid;//Undocumented
				case 76:	return new Callproplex;
				case 77:	return new Callinterface;//Undocumented
				case 78:	return new Callsupervoid;
				case 79:	return new Callpropvoid;
				case 80:	return new Sxi_1;
				case 81:	return new Sxi_8;
				case 82:	return new Sxi_16;
				case 83:	return new Applytype;//Undocumented
//				case 84:
				case 85:	return new Newobject;
				case 86:	return new Newarray;
				case 87:	return new Newactivation;
				case 88:	return new Newclass;
				case 89:	return new Getdescendants;
				case 90:	return new Newcatch;
				case 91:	return new Findpropglobalstrict;//Undocumented
				case 92:	return new Findpropglobal;//Undocumented
				case 93:	return new Findpropstrict;
				case 94:	return new Findproperty;
				case 95:	return new Finddef;//Undocumented
				case 96:	return new Getlex;
				case 97:	return new Setproperty;
				case 98:	return new Getlocal;
				case 99:	return new Setlocal;
				case 100:	return new Getglobalscope;
				case 101:	return new Getscopeobject;
				case 102:	return new Getproperty;
				case 103:	return new Getouterscope;//Undocumented
				case 104:	return new Initproperty;
				case 106:	return new Deleteproperty;
				case 107:	return new Deletepropertylate;//Undocumented
				case 108:	return new Getslot;
				case 109:	return new Setslot;
				case 110:	return new Getglobalslot;
				case 111:	return new Setglobalslot;
				case 112:	return new Convert_s;
				case 113:	return new Esc_xelem;
				case 114:	return new Esc_xattr;
				case 115:	return new Convert_i;
				case 116:	return new Convert_u;
				case 117:	return new Convert_d;
				case 118:	return new Convert_b;
				case 119:	return new Convert_o;
				case 120:	return new Checkfilter;
//				case 121:
//				case 122:
//				case 123:
//				case 124:
//				case 125:
//				case 126:
//				case 127:
				case 128:	return new Coerce;
				case 129:	return new Coerce_b;//Undocumented
				case 130:	return new Coerce_a;
				case 131:	return new Coerce_i;//Undocumented
				case 132:	return new Coerce_d;//Undocumented
				case 133:	return new Coerce_s;
				case 134:	return new Astype;
				case 135:	return new Astypelate;
				case 136:	return new Coerce_u;//Undocumented
				case 137:	return new Coerce_o;//Undocumented
//				case 138:
//				case 139:
//				case 140:
//				case 141:
//				case 142:
//				case 143:
				case 144:	return new Negate;
				case 145:	return new Increment;
				case 146:	return new Inclocal;
				case 147:	return new Decrement;
				case 148:	return new Declocal;
				case 149:	return new Typeof;
				case 150:	return new Not;
				case 151:	return new Bitnot;
//				case 152:
//				case 153:
				case 154:	return new Concat;//Undocumented
				case 155:	return new Add_d;
//				case 156:
//				case 157:
//				case 158:
//				case 159:
				case 160:	return new Add;
				case 161:	return new Subtract;
				case 162:	return new Multiply;
				case 163:	return new Divide;
				case 164:	return new Modulo;
				case 165:	return new Lshift;
				case 166:	return new Rshift;
				case 167:	return new Urshift;
				case 168:	return new Bitand;
				case 169:	return new Bitor;
				case 170:	return new Bitxor;
				case 171:	return new Equals;
				case 172:	return new Strictequals;
				case 173:	return new Lessthan;
				case 174:	return new Lessequals;
				case 175:	return new Greaterthan;
				case 176:	return new Greaterequals;
				case 177:	return new Instanceof;
				case 178:	return new Istype;
				case 179:	return new Istypelate;
				case 180:	return new In;
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
				case 192:	return new Increment_i;
				case 193:	return new Decrement_i;
				case 194:	return new Inclocal_i;
				case 195:	return new Declocal_i;
				case 196:	return new Negate_i;
				case 197:	return new Add_i;
				case 199:	return new Multiply_i;
				case 198:	return new Subtract_i;
//				case 199:
//				case 200:
//				case 201:
//				case 202:
//				case 203:
//				case 204:
//				case 205:
//				case 206:
//				case 207:
				case 208:	return new Getlocal_0;
				case 209:	return new Getlocal_1;
				case 210:	return new Getlocal_2;
				case 211:	return new Getlocal_3;
				case 212:	return new Setlocal_0;
				case 213:	return new Setlocal_1;
				case 214:	return new Setlocal_2;
				case 215:	return new Setlocal_3;
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
				case 238:	return new Abs_jump;
				case 239:	return new Debug;
				case 240:	return new Debugline;
				case 241:	return new Debugfile;
				case 242:	return new Bkptline;//Undocumented
				case 243:	return new Timestamp;//Undocumented
//				case 244:	
				case 245:	return new Verifypass;//Undocumented
				case 246:	return new Alloc;//Undocumented
				case 247:	return new Mark;//Undocumented
				case 248:	return new Wb;//Undocumented
				case 249:	return new Prologue;//Undocumented
				case 250:	return new Sendenter;//Undocumented
				case 251:	return new Doubletoatom;//Undocumented
				case 252:	return new Sweep;//Undocumented
				case 253:	return new Codegenop;//Undocumented
				case 254:	return new Verifyop;//Undocumented
				case 255:	return new Decode;//Undocumented
				default:
					throw new Error("未识别的PCode操作码:" + forms);
					break;
			}
		}
	}
}