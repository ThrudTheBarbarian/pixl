`timescale 1ns/1ns
`include "defines.v"

///////////////////////////////////////////////////////////////////////////////
// Page map module. 
//
// Keeps a 256-bit register-map updated so we know when to map SDRAM in for the
// A8. 
///////////////////////////////////////////////////////////////////////////////
module page_map
    (
    input 					clk200,		// Main FPGA clock from PLL @ 200 MHz
	input					a8_rst_n,	// A8 /RST signal
	input		[1:0]		op,			// What to do
	input		[7:0]		from,		// Low page id
	input		[7:0]		size,		// Number of pages
	
	output reg				valid,		// The current state is valid
	output reg	[255:0]		map			// The actual map
	);
	
	///////////////////////////////////////////////////////////////////////////
	// Define some states we'll use to process the incoming data
	///////////////////////////////////////////////////////////////////////////
	localparam STATE_MASK_WAIT		= 0;
	localparam STATE_MASK_SHIFT		= 1;
	localparam STATE_MASK_COMBINE	= 2;
	
	
	///////////////////////////////////////////////////////////////////////////
	// Instantiate a block-ram to read the mask value from
	///////////////////////////////////////////////////////////////////////////
	wire 	[255:0]			mask_bits;	// The first-stage result
	reg 	[255:0]			shift_bits;	// The second-stage result
	reg		[7:0]			mask_addr;	// The address pointer
	
	mask_ram mask1
		(
		.clk200(clk200),
		.addr(mask_addr),
		.data(mask_bits)
		);
		
	///////////////////////////////////////////////////////////////////////////
	// Local work registers
	///////////////////////////////////////////////////////////////////////////
	reg [2:0] 	state;
	reg	[7:0]	shift;
	reg	[1:0]	action;
	
	always @ (posedge clk200)
		if (a8_rst_n == 1'b0)
			begin
				map 	<= 256'h40;
				state	<= STATE_MASK_WAIT;
				shift	<= 8'h0;
				action	<= `OP_NONE;
			end
		else 
			case (state)
				STATE_MASK_SHIFT:
					begin
						case (shift)
							0:		shift_bits <=  mask_bits[255:0];
							1:		shift_bits <= {mask_bits[254:0],1'b0};
							2:		shift_bits <= {mask_bits[253:0],2'b0};
							3:		shift_bits <= {mask_bits[252:0],3'b0};
							4:		shift_bits <= {mask_bits[251:0],4'b0};
							5:		shift_bits <= {mask_bits[250:0],5'b0};
							6:		shift_bits <= {mask_bits[249:0],6'b0};
							7:		shift_bits <= {mask_bits[248:0],7'b0};
							8:		shift_bits <= {mask_bits[247:0],8'b0};
							9:		shift_bits <= {mask_bits[246:0],9'b0};
							10:		shift_bits <= {mask_bits[245:0],10'b0};
							11:		shift_bits <= {mask_bits[244:0],11'b0};
							12:		shift_bits <= {mask_bits[243:0],12'b0};
							13:		shift_bits <= {mask_bits[242:0],13'b0};
							14:		shift_bits <= {mask_bits[241:0],14'b0};
							15:		shift_bits <= {mask_bits[240:0],15'b0};
							16:		shift_bits <= {mask_bits[239:0],16'b0};
							17:		shift_bits <= {mask_bits[238:0],17'b0};
							18:		shift_bits <= {mask_bits[237:0],18'b0};
							19:		shift_bits <= {mask_bits[236:0],19'b0};
							20:		shift_bits <= {mask_bits[235:0],20'b0};
							21:		shift_bits <= {mask_bits[234:0],21'b0};
							22:		shift_bits <= {mask_bits[233:0],22'b0};
							23:		shift_bits <= {mask_bits[232:0],23'b0};
							24:		shift_bits <= {mask_bits[231:0],24'b0};
							25:		shift_bits <= {mask_bits[230:0],25'b0};
							26:		shift_bits <= {mask_bits[229:0],26'b0};
							27:		shift_bits <= {mask_bits[228:0],27'b0};
							28:		shift_bits <= {mask_bits[227:0],28'b0};
							29:		shift_bits <= {mask_bits[226:0],29'b0};
							30:		shift_bits <= {mask_bits[225:0],30'b0};
							31:		shift_bits <= {mask_bits[224:0],31'b0};
							32:		shift_bits <= {mask_bits[223:0],32'b0};
							33:		shift_bits <= {mask_bits[222:0],33'b0};
							34:		shift_bits <= {mask_bits[221:0],34'b0};
							35:		shift_bits <= {mask_bits[220:0],35'b0};
							36:		shift_bits <= {mask_bits[219:0],36'b0};
							37:		shift_bits <= {mask_bits[218:0],37'b0};
							38:		shift_bits <= {mask_bits[217:0],38'b0};
							39:		shift_bits <= {mask_bits[216:0],39'b0};
							40:		shift_bits <= {mask_bits[215:0],40'b0};
							41:		shift_bits <= {mask_bits[214:0],41'b0};
							42:		shift_bits <= {mask_bits[213:0],42'b0};
							43:		shift_bits <= {mask_bits[212:0],43'b0};
							44:		shift_bits <= {mask_bits[211:0],44'b0};
							45:		shift_bits <= {mask_bits[210:0],45'b0};
							46:		shift_bits <= {mask_bits[209:0],46'b0};
							47:		shift_bits <= {mask_bits[208:0],47'b0};
							48:		shift_bits <= {mask_bits[207:0],48'b0};
							49:		shift_bits <= {mask_bits[206:0],49'b0};
							50:		shift_bits <= {mask_bits[205:0],50'b0};
							51:		shift_bits <= {mask_bits[204:0],51'b0};
							52:		shift_bits <= {mask_bits[203:0],52'b0};
							53:		shift_bits <= {mask_bits[202:0],53'b0};
							54:		shift_bits <= {mask_bits[201:0],54'b0};
							55:		shift_bits <= {mask_bits[200:0],55'b0};
							56:		shift_bits <= {mask_bits[199:0],56'b0};
							57:		shift_bits <= {mask_bits[198:0],57'b0};
							58:		shift_bits <= {mask_bits[197:0],58'b0};
							59:		shift_bits <= {mask_bits[196:0],59'b0};
							60:		shift_bits <= {mask_bits[195:0],60'b0};
							61:		shift_bits <= {mask_bits[194:0],61'b0};
							62:		shift_bits <= {mask_bits[193:0],62'b0};
							63:		shift_bits <= {mask_bits[192:0],63'b0};
							64:		shift_bits <= {mask_bits[191:0],64'b0};
							65:		shift_bits <= {mask_bits[190:0],65'b0};
							66:		shift_bits <= {mask_bits[189:0],66'b0};
							67:		shift_bits <= {mask_bits[188:0],67'b0};
							68:		shift_bits <= {mask_bits[187:0],68'b0};
							69:		shift_bits <= {mask_bits[186:0],69'b0};
							70:		shift_bits <= {mask_bits[185:0],70'b0};
							71:		shift_bits <= {mask_bits[184:0],71'b0};
							72:		shift_bits <= {mask_bits[183:0],72'b0};
							73:		shift_bits <= {mask_bits[182:0],73'b0};
							74:		shift_bits <= {mask_bits[181:0],74'b0};
							75:		shift_bits <= {mask_bits[180:0],75'b0};
							76:		shift_bits <= {mask_bits[179:0],76'b0};
							77:		shift_bits <= {mask_bits[178:0],77'b0};
							78:		shift_bits <= {mask_bits[177:0],78'b0};
							79:		shift_bits <= {mask_bits[176:0],79'b0};
							80:		shift_bits <= {mask_bits[175:0],80'b0};
							81:		shift_bits <= {mask_bits[174:0],81'b0};
							82:		shift_bits <= {mask_bits[173:0],82'b0};
							83:		shift_bits <= {mask_bits[172:0],83'b0};
							84:		shift_bits <= {mask_bits[171:0],84'b0};
							85:		shift_bits <= {mask_bits[170:0],85'b0};
							86:		shift_bits <= {mask_bits[169:0],86'b0};
							87:		shift_bits <= {mask_bits[168:0],87'b0};
							88:		shift_bits <= {mask_bits[167:0],88'b0};
							89:		shift_bits <= {mask_bits[166:0],89'b0};
							90:		shift_bits <= {mask_bits[165:0],90'b0};
							91:		shift_bits <= {mask_bits[164:0],91'b0};
							92:		shift_bits <= {mask_bits[163:0],92'b0};
							93:		shift_bits <= {mask_bits[162:0],93'b0};
							94:		shift_bits <= {mask_bits[161:0],94'b0};
							95:		shift_bits <= {mask_bits[160:0],95'b0};
							96:		shift_bits <= {mask_bits[159:0],96'b0};
							97:		shift_bits <= {mask_bits[158:0],97'b0};
							98:		shift_bits <= {mask_bits[157:0],98'b0};
							99:		shift_bits <= {mask_bits[156:0],99'b0};
							100:	shift_bits <= {mask_bits[155:0],100'b0};
							101:	shift_bits <= {mask_bits[154:0],101'b0};
							102:	shift_bits <= {mask_bits[153:0],102'b0};
							103:	shift_bits <= {mask_bits[152:0],103'b0};
							104:	shift_bits <= {mask_bits[151:0],104'b0};
							105:	shift_bits <= {mask_bits[150:0],105'b0};
							106:	shift_bits <= {mask_bits[149:0],106'b0};
							107:	shift_bits <= {mask_bits[148:0],107'b0};
							108:	shift_bits <= {mask_bits[147:0],108'b0};
							109:	shift_bits <= {mask_bits[146:0],109'b0};
							110:	shift_bits <= {mask_bits[145:0],110'b0};
							111:	shift_bits <= {mask_bits[144:0],111'b0};
							112:	shift_bits <= {mask_bits[143:0],112'b0};
							113:	shift_bits <= {mask_bits[142:0],113'b0};
							114:	shift_bits <= {mask_bits[141:0],114'b0};
							115:	shift_bits <= {mask_bits[140:0],115'b0};
							116:	shift_bits <= {mask_bits[139:0],116'b0};
							117:	shift_bits <= {mask_bits[138:0],117'b0};
							118:	shift_bits <= {mask_bits[137:0],118'b0};
							119:	shift_bits <= {mask_bits[136:0],119'b0};
							120:	shift_bits <= {mask_bits[135:0],120'b0};
							121:	shift_bits <= {mask_bits[134:0],121'b0};
							122:	shift_bits <= {mask_bits[133:0],122'b0};
							123:	shift_bits <= {mask_bits[132:0],123'b0};
							124:	shift_bits <= {mask_bits[131:0],124'b0};
							125:	shift_bits <= {mask_bits[130:0],125'b0};
							126:	shift_bits <= {mask_bits[129:0],126'b0};
							127:	shift_bits <= {mask_bits[128:0],127'b0};
							128:	shift_bits <= {mask_bits[127:0],128'b0};
							129:	shift_bits <= {mask_bits[126:0],129'b0};
							130:	shift_bits <= {mask_bits[125:0],130'b0};
							131:	shift_bits <= {mask_bits[124:0],131'b0};
							132:	shift_bits <= {mask_bits[123:0],132'b0};
							133:	shift_bits <= {mask_bits[122:0],133'b0};
							134:	shift_bits <= {mask_bits[121:0],134'b0};
							135:	shift_bits <= {mask_bits[120:0],135'b0};
							136:	shift_bits <= {mask_bits[119:0],136'b0};
							137:	shift_bits <= {mask_bits[118:0],137'b0};
							138:	shift_bits <= {mask_bits[117:0],138'b0};
							139:	shift_bits <= {mask_bits[116:0],139'b0};
							140:	shift_bits <= {mask_bits[115:0],140'b0};
							141:	shift_bits <= {mask_bits[114:0],141'b0};
							142:	shift_bits <= {mask_bits[113:0],142'b0};
							143:	shift_bits <= {mask_bits[112:0],143'b0};
							144:	shift_bits <= {mask_bits[111:0],144'b0};
							145:	shift_bits <= {mask_bits[110:0],145'b0};
							146:	shift_bits <= {mask_bits[109:0],146'b0};
							147:	shift_bits <= {mask_bits[108:0],147'b0};
							148:	shift_bits <= {mask_bits[107:0],148'b0};
							149:	shift_bits <= {mask_bits[106:0],149'b0};
							150:	shift_bits <= {mask_bits[105:0],150'b0};
							151:	shift_bits <= {mask_bits[104:0],151'b0};
							152:	shift_bits <= {mask_bits[103:0],152'b0};
							153:	shift_bits <= {mask_bits[102:0],153'b0};
							154:	shift_bits <= {mask_bits[101:0],154'b0};
							155:	shift_bits <= {mask_bits[100:0],155'b0};
							156:	shift_bits <= {mask_bits[99:0],156'b0};
							157:	shift_bits <= {mask_bits[98:0],157'b0};
							158:	shift_bits <= {mask_bits[97:0],158'b0};
							159:	shift_bits <= {mask_bits[96:0],159'b0};
							160:	shift_bits <= {mask_bits[95:0],160'b0};
							161:	shift_bits <= {mask_bits[94:0],161'b0};
							162:	shift_bits <= {mask_bits[93:0],162'b0};
							163:	shift_bits <= {mask_bits[92:0],163'b0};
							164:	shift_bits <= {mask_bits[91:0],164'b0};
							165:	shift_bits <= {mask_bits[90:0],165'b0};
							166:	shift_bits <= {mask_bits[89:0],166'b0};
							167:	shift_bits <= {mask_bits[88:0],167'b0};
							168:	shift_bits <= {mask_bits[87:0],168'b0};
							169:	shift_bits <= {mask_bits[86:0],169'b0};
							170:	shift_bits <= {mask_bits[85:0],170'b0};
							171:	shift_bits <= {mask_bits[84:0],171'b0};
							172:	shift_bits <= {mask_bits[83:0],172'b0};
							173:	shift_bits <= {mask_bits[82:0],173'b0};
							174:	shift_bits <= {mask_bits[81:0],174'b0};
							175:	shift_bits <= {mask_bits[80:0],175'b0};
							176:	shift_bits <= {mask_bits[79:0],176'b0};
							177:	shift_bits <= {mask_bits[78:0],177'b0};
							178:	shift_bits <= {mask_bits[77:0],178'b0};
							179:	shift_bits <= {mask_bits[76:0],179'b0};
							180:	shift_bits <= {mask_bits[75:0],180'b0};
							181:	shift_bits <= {mask_bits[74:0],181'b0};
							182:	shift_bits <= {mask_bits[73:0],182'b0};
							183:	shift_bits <= {mask_bits[72:0],183'b0};
							184:	shift_bits <= {mask_bits[71:0],184'b0};
							185:	shift_bits <= {mask_bits[70:0],185'b0};
							186:	shift_bits <= {mask_bits[69:0],186'b0};
							187:	shift_bits <= {mask_bits[68:0],187'b0};
							188:	shift_bits <= {mask_bits[67:0],188'b0};
							189:	shift_bits <= {mask_bits[66:0],189'b0};
							190:	shift_bits <= {mask_bits[65:0],190'b0};
							191:	shift_bits <= {mask_bits[64:0],191'b0};
							192:	shift_bits <= {mask_bits[63:0],192'b0};
							193:	shift_bits <= {mask_bits[62:0],193'b0};
							194:	shift_bits <= {mask_bits[61:0],194'b0};
							195:	shift_bits <= {mask_bits[60:0],195'b0};
							196:	shift_bits <= {mask_bits[59:0],196'b0};
							197:	shift_bits <= {mask_bits[58:0],197'b0};
							198:	shift_bits <= {mask_bits[57:0],198'b0};
							199:	shift_bits <= {mask_bits[56:0],199'b0};
							200:	shift_bits <= {mask_bits[55:0],200'b0};
							201:	shift_bits <= {mask_bits[54:0],201'b0};
							202:	shift_bits <= {mask_bits[53:0],202'b0};
							203:	shift_bits <= {mask_bits[52:0],203'b0};
							204:	shift_bits <= {mask_bits[51:0],204'b0};
							205:	shift_bits <= {mask_bits[50:0],205'b0};
							206:	shift_bits <= {mask_bits[49:0],206'b0};
							207:	shift_bits <= {mask_bits[48:0],207'b0};
							208:	shift_bits <= {mask_bits[47:0],208'b0};
							209:	shift_bits <= {mask_bits[46:0],209'b0};
							210:	shift_bits <= {mask_bits[45:0],210'b0};
							211:	shift_bits <= {mask_bits[44:0],211'b0};
							212:	shift_bits <= {mask_bits[43:0],212'b0};
							213:	shift_bits <= {mask_bits[42:0],213'b0};
							214:	shift_bits <= {mask_bits[41:0],214'b0};
							215:	shift_bits <= {mask_bits[40:0],215'b0};
							216:	shift_bits <= {mask_bits[39:0],216'b0};
							217:	shift_bits <= {mask_bits[38:0],217'b0};
							218:	shift_bits <= {mask_bits[37:0],218'b0};
							219:	shift_bits <= {mask_bits[36:0],219'b0};
							220:	shift_bits <= {mask_bits[35:0],220'b0};
							221:	shift_bits <= {mask_bits[34:0],221'b0};
							222:	shift_bits <= {mask_bits[33:0],222'b0};
							223:	shift_bits <= {mask_bits[32:0],223'b0};
							224:	shift_bits <= {mask_bits[31:0],224'b0};
							225:	shift_bits <= {mask_bits[30:0],225'b0};
							226:	shift_bits <= {mask_bits[29:0],226'b0};
							227:	shift_bits <= {mask_bits[28:0],227'b0};
							228:	shift_bits <= {mask_bits[27:0],228'b0};
							229:	shift_bits <= {mask_bits[26:0],229'b0};
							230:	shift_bits <= {mask_bits[25:0],230'b0};
							231:	shift_bits <= {mask_bits[24:0],231'b0};
							232:	shift_bits <= {mask_bits[23:0],232'b0};
							233:	shift_bits <= {mask_bits[22:0],233'b0};
							234:	shift_bits <= {mask_bits[21:0],234'b0};
							235:	shift_bits <= {mask_bits[20:0],235'b0};
							236:	shift_bits <= {mask_bits[19:0],236'b0};
							237:	shift_bits <= {mask_bits[18:0],237'b0};
							238:	shift_bits <= {mask_bits[17:0],238'b0};
							239:	shift_bits <= {mask_bits[16:0],239'b0};
							240:	shift_bits <= {mask_bits[15:0],240'b0};
							241:	shift_bits <= {mask_bits[14:0],241'b0};
							242:	shift_bits <= {mask_bits[13:0],242'b0};
							243:	shift_bits <= {mask_bits[12:0],243'b0};
							244:	shift_bits <= {mask_bits[11:0],244'b0};
							245:	shift_bits <= {mask_bits[10:0],245'b0};
							246:	shift_bits <= {mask_bits[9:0],246'b0};
							247:	shift_bits <= {mask_bits[8:0],247'b0};
							248:	shift_bits <= {mask_bits[7:0],248'b0};
							249:	shift_bits <= {mask_bits[6:0],249'b0};
							250:	shift_bits <= {mask_bits[5:0],250'b0};
							251:	shift_bits <= {mask_bits[4:0],251'b0};
							252:	shift_bits <= {mask_bits[3:0],252'b0};
							253:	shift_bits <= {mask_bits[2:0],253'b0};
							254:	shift_bits <= {mask_bits[1:0],254'b0};
							255:	shift_bits <= 255'b0;
						endcase
						state <= STATE_MASK_COMBINE;
					end
					
				STATE_MASK_COMBINE:
					begin
						if (action == `OP_ADD)
							map <= map | shift_bits;
						else
							map <= map & (~shift_bits);
							
						state  <= STATE_MASK_WAIT;
					end

				STATE_MASK_WAIT:
					begin
					if (op != `OP_NONE) 
						begin
							mask_addr 	<= size;
							state		<= STATE_MASK_SHIFT;
							action		<= op;
							shift		<= from;
						end
					end
				default:
					;
			endcase				

endmodule