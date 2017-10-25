//
//  BLEData.h
//  MagicFan
//
//  Created by zc on 2017/6/19.
//  Copyright © 2017年 IMpBear. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark -- 大写字母字库取的数据
static char A_byte[]={0x00,0x00,0xf0,0x8e,0xb8,0xc0,0x00,0x00,    0x00,0x00,0x00,0x00,    0xf8,0x08,0x90,0x8e,0x00,0x00};//测试OK

static char B_byte[]={0x02,0xfe,0x22,0x22,0x22,0x5C,0x80,0x00,    0x00,0x00,0x00,0x00,    0xf8,0x88,0x48,0x03,0x00,0x00};//测试OK

static char C_byte[]={0xf0,0x0c,0x02,0x02,0x02,0x02,0x0e,0x00,    0x00,0x00,0x00,0x00,    0x61,0x88,0x48,0x02,0x00,0x00};//测试OK

static char D_byte[]={0x02,0xfe,0x02,0x02,0x02,0x04,0xf8,0x00,    0x00,0x00,0x00,0x00,    0xf8,0x88,0x48,0x03,0x00,0x00};//测试OK

static char E_byte[]={0x02,0xfe,0x22,0x22,0xfa,0x02,0x06,0x00,    0x00,0x00,0x00,0x00,    0xf8,0x88,0x88,0x0e,0x00,0x00};//测试OK

static char F_byte[]={0x02,0xfe,0x22,0x22,0xfa,0x02,0x06,0x00,    0x00,0x00,0x00,0x00,    0xf8,0x08,0x00,0x00,0x00,0x00};//ok

static char G_byte[]={0xf0,0x0c,0x02,0x02,0x82,0x8e,0x80,0x00,    0x00,0x00,0x00,0x00,    0x61,0x88,0x78,0x00,0x00,0x00};//OK

static char H_byte[]={0x02,0xFE,0x42,0x40,0x40,0x42,0xFE,0x02,    0x00,0x00,0x00,0x00,    0xF8,0x08,0x80,0x8F,0x00,0x00};//OK

static char I_byte[]={0x00,0x02,0x02,0xFE,0x02,0x02,0x00,0x00,    0x00,0x00,0x00,0x00,    0x80,0xF8,0x88,0x00,0x00,0x00};//OK

static char J_byte[]={0x00,0x00,0x02,0x02,0xFE,0x02,0x02,0x00,    0x00,0x00,0x00,0x00,    0x8C,0x88,0x07,0x00,0x00,0x00};//OK

static char K_byte[]={0x02,0xFE,0x22,0x70,0x8A,0x06,0x02,0x00,    0x00,0x00,0x00,0x00,    0xF8,0x08,0xE9,0x08,0x00,0x00};//OK

static char L_byte[]={0x02,0xFE,0x02,0x00,0x00,0x00,0x00,0x00,    0x00,0x00,0x00,0x00,    0xF8,0x88,0x88,0x0C,0x00,0x00};//OK

static char M_byte[]={0x02,0xFE,0x3E,0xC0,0x3E,0xFE,0x02,0x00,    0x00,0x00,0x00,0x00,    0xf8,0xF0,0xF0,0x08,0x00,0x00};//OK

static char N_byte[]={0x02,0xFE,0x0A,0x30,0xB0,0x02,0xFE,0x02,    0x00,0x00,0x00,0x00,    0xf8,0x08,0x61,0x0F,0x00,0x00};//OK

static char O_byte[]={0xF8,0x04,0x02,0x02,0x02,0x04,0xF8,0x00,    0x00,0x00,0x00,0x00,    0x43,0x88,0x48,0x03,0x00,0x00};//OK

static char P_byte[]={0x02,0xFE,0x42,0x42,0x42,0x42,0x3C,0x00,    0x00,0x00,0x00,0x00,    0xF8,0x08,0x00,0x00,0x00,0x00};//OK

static char Q_byte[]={0xF8,0x04,0x82,0x82,0x02,0x04,0xF8,0x00,    0x00,0x00,0x00,0x00,    0x31,0x44,0xA7,0x09,0x00,0x00};//OK

static char R_byte[]={0x02,0xFE,0x22,0x22,0xE2,0x22,0x1C,0x00,    0x00,0x00,0x00,0x00,    0xF8,0x08,0x30,0x8A,0x00,0x00};//OK

static char S_byte[]={0x00,0x1C,0x22,0x42,0x42,0x82,0x0E,0x00,    0x00,0x00,0x00,0x00,    0xE0,0x88,0x88,0x07,0x00,0x00};//OK

static char T_byte[]={0x06,0x02,0x02,0xFE,0x02,0x02,0x06,0x00,    0x00,0x00,0x00,0x00,    0x00,0xF8,0x08,0x00,0x00,0x00};//OK

static char U_byte[]={0x02,0xFE,0x02,0x00,0x00,0x02,0xFE,0x02,    0x00,0x00,0x00,0x00,    0x70,0x88,0x88,0x07,0x00,0x00};//OK

static char V_byte[]={0x02,0x1E,0xE2,0x00,0x80,0x72,0x0E,0x02,    0x00,0x00,0x00,0x00,    0x00,0xE1,0x03,0x00,0x00,0x00};//OK

static char W_byte[]={0xFE,0x02,0xC0,0x3e,0xC0,0x02,0xFE,0x00,    0x00,0x00,0x00,0x00,    0xF0,0x01,0xF1,0x00,0x00,0x00};//OK

static char X_byte[]={0x02,0x06,0x1A,0xE0,0xE0,0x1A,0x06,0x02,    0x00,0x00,0x00,0x00,    0xC8,0x0B,0xB0,0x8C,0x00,0x00};//OK

static char Y_byte[]={0x02,0x0E,0x32,0xC0,0x32,0x0E,0x02,0x00,    0x00,0x00,0x00,0x00,    0x00,0xF8,0x08,0x00,0x00,0x00};//OK

static char Z_byte[]={0x06,0x02,0x82,0x42,0x32,0x0E,0x02,0x00,    0x00,0x00,0x00,0x00,    0xE8,0x89,0x88,0x0E,0x00,0x00};//OK

#pragma mark -- 小写字母取得数据
static char a_byte[]={0x00,0x40,0x20,0xa0,0xa0,0xa0,0xc0,0x00,    0x00,0x00,0x00,0x00,    0x60,0x89,0x88,0x8f,0x00,0x00};

static char b_byte[]={0x02,0xfe,0x40,0x20,0x20,0x40,0x80,0x00,    0x00,0x00,0x00,0x00,    0xf0,0x86,0x68,0x03,0x00,0x00};

static char c_byte[]={0x00,0x80,0x40,0x20,0x20,0x20,0x40,0x00,    0x00,0x00,0x00,0x00,	  0x30,0x86,0x88,0x06,0x00,0x00};

static char d_byte[]={0x00,0x80,0x40,0x20,0x20,0x22,0xfe,0x00,    0x00,0x00,0x00,0x00,	  0x30,0x86,0x68,0x8f,0x00,0x00};

static char e_byte[]={0x00,0xc0,0xa0,0xa0,0xa0,0xa0,0xc0,0x00,    0x00,0x00,0x00,0x00,    0x70,0x88,0x88,0x04,0x00,0x00};

static char f_byte[]={0x00,0x20,0x20,0xfc,0x22,0x22,0x22,0x06,    0x00,0x00,0x00,0x00,	  0x80,0xf8,0x88,0x00,0x00,0x00};

static char g_byte[]={0x00,0xac,0x52,0x52,0x52,0x4E,0x82,0x00,	  0x00,0x00,0x00,0x00,	  0x60,0x99,0x99,0x06,0x00,0x00};//

static char h_byte[]={0x02,0xfe,0x40,0x20,0x20,0x20,0xc0,0x00,	  0x00,0x00,0x00,0x00,	  0xf8,0x08,0x80,0x8f,0x00,0x00};//

static char i_byte[]={0x00,0x20,0x26,0xe6,0x00,0x00,0x00,0x00,	  0x00,0x00,0x00,0x00,	  0x80,0xf8,0x88,0x00,0x00,0x00};//

static char j_byte[]={0x00,0x00,0x00,0x10,0x16,0xf6,0x00,0x00,    0x00,0x00,0x00,0x00,    0xc0,0x88,0x78,0x00,0x00,0x00};//

static char k_byte[]={0x02,0xfe,0x00,0x80,0x60,0x20,0x20,0x00,	0x00,0x00,0x00,0x00,	0xf8,0x09,0xcb,0x08,0x00,0x00};

static char l_byte[]={0x00,0x02,0x02,0xfe,0x00,0x00,0x00,0x00,	0x00,0x00,0x00,0x00,	0x80,0xf8,0x88,0x00,0x00,0x00};

static char m_byte[]={0x20,0xe0,0x20,0x20,0xe0,0x20,0x20,0xc0,	0x00,0x00,0x00,0x00,	0xf8,0x08,0x8f,0xf0,0x00,0x00};

static char n_byte[]={0x20,0xe0,0x40,0x20,0x20,0x20,0xc0,0x00,	0x00,0x00,0x00,0x00,	0xf8,0x08,0x80,0x8f,0x00,0x00};

static char o_byte[]={0x00,0xc0,0x20,0x20,0x20,0x20,0xc0,0x00,	0x00,0x00,0x00,0x00,	0x70,0x88,0x88,0x07,0x00,0x00};//

static char p_byte[]={0x08,0xf8,0x10,0x08,0x08,0x10,0xe0,0x00,	0x00,0x00,0x00,0x00,	0xf8,0x2a,0x12,0x00,0x00,0x00};

static char q_byte[]={0x00,0xe0,0x10,0x08,0x08,0x08,0xf8,0x00,	0x00,0x00,0x00,0x00,	0x00,0x21,0xa2,0x8f,0x00,0x00};//

static char r_byte[]={0x20,0x20,0xe0,0x40,0x20,0x20,0x60,0x00,	0x00,0x00,0x00,0x00,	0x88,0x8f,0x08,0x00,0x00,0x00};

static char s_byte[]={0x00,0xc0,0x20,0x20,0x20,0x20,0x60,0x00,	0x00,0x00,0x00,0x00,	0xc0,0x99,0x99,0x06,0x00,0x00};

static char t_byte[]={0x00,0x20,0x20,0xf8,0x20,0x20,0x00,0x00,	0x00,0x00,0x00,0x00,	0x00,0x70,0x88,0x00,0x00,0x00};

static char u_byte[]={0x20,0xe0,0x00,0x00,0x00,0x20,0xe0,0x00,	0x00,0x00,0x00,0x00,	0x70,0x88,0x68,0x8f,0x00,0x00};//

static char v_byte[]={0x20,0x60,0xa0,0x00,0x00,0xa0,0x60,0x20,	0x00,0x00,0x00,0x00,	0x00,0xc3,0x12,0x00,0x00,0x00};

static char w_byte[]={0xe0,0x20,0x00,0xe0,0x00,0x20,0xe0,0x20,	0x00,0x00,0x00,0x00,	0xc3,0x03,0xc3,0x03,0x00,0x00};

static char x_byte[]={0x00,0x20,0x60,0x80,0xa0,0x60,0x20,0x00,	0x00,0x00,0x00,0x00,	0x80,0xbc,0xc3,0x08,0x00,0x00};

static char y_byte[]={0x08,0x18,0xe8,0x00,0x80,0x68,0x18,0x08,	0x00,0x00,0x00,0x00,	0x88,0x78,0x01,0x00,0x00,0x00};

static char z_byte[]={0x00,0x60,0x20,0x20,0xa0,0x60,0x20,0x00,	0x00,0x00,0x00,0x00,	0x80,0xbc,0x88,0x0c,0x00,0x00};

static char *byteAll[] ={A_byte,B_byte,C_byte,D_byte,E_byte,F_byte,G_byte,H_byte,I_byte,J_byte,K_byte,L_byte,M_byte,N_byte,O_byte,P_byte,Q_byte,R_byte,S_byte,T_byte,U_byte,V_byte,W_byte,X_byte,Y_byte,Z_byte,
                         a_byte,b_byte,c_byte,d_byte,e_byte,f_byte,g_byte,h_byte,i_byte,j_byte,k_byte,l_byte,m_byte,n_byte,o_byte,p_byte,
    q_byte,r_byte,s_byte,t_byte,u_byte,v_byte,w_byte,x_byte,y_byte,z_byte};

@interface BLEData : NSObject

@end
