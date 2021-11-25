CSEG SEGMENT 
   ASSUME CS:CSEG, DS:CSEG, ES:CSEG
   ORG 100H

SAUT_DE_LIGNE MACRO
    MOV AH,2
    MOV DL, 0DH
    INT 21H
    MOV DL,0AH
    INT 21H
ENDM
      
MAIN:

; ********** MAIN : Affichage MENU **********
	MOV AH, 0
	MOV AL, 6H
	INT 10H
	
	SAUT_DE_LIGNE
	MOV AH,09H
	LEA DX, CHAINE1
	INT 21H

	SAUT_DE_LIGNE
	MOV AH,09H
	LEA DX, CHAINE2
	INT 21H
	SAUT_DE_LIGNE
	
	SAUT_DE_LIGNE
	MOV AH,09H
	LEA DX, CHAINE3
	INT 21H
	
	SAUT_DE_LIGNE
	MOV AH,09H
	LEA DX, CHAINE4
	INT 21H

	SAUT_DE_LIGNE
	MOV AH,09H
	LEA DX, CHAINE5
	INT 21H
	
	SAUT_DE_LIGNE
	MOV AH,09H
	LEA DX, CHAINE6
	INT 21H
	
	SAUT_DE_LIGNE
	MOV AH, 09H
	LEA DX, CHAINE11
	INT 21H
	
	SAUT_DE_LIGNE
	MOV AH,09H
	LEA DX, CHAINE7
	INT 21H
	
	SAUT_DE_LIGNE
	MOV AH,09H
	LEA DX, CHAINE8
	INT 21H

	SAUT_DE_LIGNE
	MOV AH,09H
	LEA DX, CHAINE10
	INT 21H
	
	SAUT_DE_LIGNE
	MOV AH,09H
	LEA DX, CHAINE9
	INT 21H

	SAUT_DE_LIGNE
	SAUT_DE_LIGNE
	MOV AH,09H
	LEA DX, CHAINE12
	INT 21H
	
	SAUT_DE_LIGNE
	MOV AH,09H
	LEA DX, CHAINE13
	INT 21H
	
	JMP DEBUT

; ********** PROCEDURE DE SAISIE **********
SAISIE PROC   
    MOV CX,0
    MOV BP,0
    
	SAISIE_DEB:
    	MOV AH,01H
    	INT 21H
		CMP AL, 08H
    	JE CORRECTION
    	CMP AL, 1BH
    	JE FERMETURE
    	CMP AL, '_'
    	JE COMPTEUR_DEB
		CMP AL,'+'
		JE SAISIE_ADDITION
		CMP AL,'*'
		JE SAISIE_MULTIPLICATION
    	CMP AL,'-'
    	JE SAISIE_SOUSTRACTION
    	CMP AL, '/'
    	JE SAISIE_DIVISION
    	CMP AL, ':'
    	JE SAISIE_EUCLIDE
    	CMP AL, '^'
    	JE SAISIE_PUISSANCE
    	CMP AL, 30H
    	JB SAISIE_DEB
    	CMP AL, 39H
        JA SAISIE_DEB
        AND AL,00001111B
        MOV BL,AL
        MOV BH,0
        MOV AX,0AH
        MUL CX
        ADD AX,BX
        MOV CX,AX
        JMP SAISIE_DEB

    SAISIE_ADDITION:
		MOV N1,CX
		MOV CX,0
		CMP BP,1
        JE ADDI_NEG
				
    	ADDI:
        	MOV AH,01H
        	INT 21H
			CMP AL, 08H
    		JE CORRECTION
        	CMP AL, 1BH
    		JE FERMETURE
        	CMP AL, '_'
        	JE SOUSTRAC
        	CMP AL,'='
        	JE ADDITION
        	CMP AL,30H
        	JB ADDI
       		CMP AL,39H
        	JA ADDI
        	AND AL,00001111B
        	MOV BL,AL
        	MOV BH,0
        	MOV AX,0AH
        	MUL CX
        	ADD AX,BX
        	MOV CX,AX
        	JMP ADDI
        	
        ADDI_NEG:
            MOV AH,01H
            INT 21H
            CMP AL, 08H
    		JE CORRECTION
			CMP AL, 1BH
			JE FERMETURE
            CMP AL,'_'
            JE SOUSTRAC1
            CMP AL,'='
            JE ADDITION_NEG
            CMP AL,30H
            JB ADDI_NEG
            CMP AL,39H
            JA ADDI_NEG
            AND AL,00001111B
            MOV BL,AL
            MOV BH,0
            MOV AX,0AH
            MUL CX
            ADD AX,BX
            MOV CX,AX
            JMP ADDI_NEG
        
    SAISIE_MULTIPLICATION:
		MOV N1,CX
		MOV CX,0
				
    	MULTI:
        	MOV AH,01H
        	INT 21H
        	CMP AL, 08H
    		JE CORRECTION
        	CMP AL, 1BH
			JE FERMETURE
        	CMP AL, '_'
        	JE COMPTEUR_MULTI
        	CMP AL,'='
        	JE MULTIPLICATION
        	CMP AL,30H
        	JB MULTI
        	CMP AL,39H
        	JA MULTI
      		AND AL,00001111B
     		MOV BL,AL
        	MOV BH,0
        	MOV AX,0AH
        	MUL CX
        	ADD AX,BX
        	MOV CX,AX
        	JMP MULTI
        
    SAISIE_PUISSANCE:
    	MOV N1, CX
    	MOV CX,0
    PUIS:
    	MOV AH,01H
        INT 21H
        CMP AL, 08H
    	JE CORRECTION
        CMP AL, 1BH
		JE FERMETURE
        CMP AL,'='
        JE PUISSANCE
        CMP AL,30H
        JB PUIS
        CMP AL,39H
        JA PUIS
      	AND AL,00001111B
     	MOV BL,AL
        MOV BH,0
        MOV AX,0AH
        MUL CX
        ADD AX,BX
        MOV CX,AX
        JMP PUIS
    	
    SAISIE_SOUSTRACTION :
		MOV N1,CX
		MOV CX,0
		CMP BP,1
        JE SOUSTRAC1
				
    	SOUSTRAC :
        	MOV AH,01H
        	INT 21H
        	CMP AL, 08H
    		JE CORRECTION
        	CMP AL, 1BH
			JE FERMETURE
        	CMP AL, '_'
        	JE SOUSTRAC3
        	CMP AL,'='
        	JE SOUSTRACTION
       		CMP AL,30H
        	JB SOUSTRAC
        	CMP AL,39H
        	JA SOUSTRAC
        	AND AL,00001111B
        	MOV BL,AL
        	MOV BH,0
        	MOV AX,0AH
        	MUL CX
        	ADD AX,BX
        	MOV CX,AX
        	JMP SOUSTRAC
        
        SOUSTRAC1:
            MOV AH,01H
            INT 21H
            CMP AL, 08H
    		JE CORRECTION
            CMP AL, 1BH
			JE FERMETURE
            CMP AL,'='
            JE SOUSTRACTION1
            CMP AL,'_'
            JE SOUSTRAC2
            CMP AL,30H
            JB SOUSTRAC1
            CMP AL,39H
            JA SOUSTRAC1
            AND AL,00001111B
            MOV BL,AL
            MOV BH,0
            MOV AX,0AH
            MUL CX
            ADD AX,BX
            MOV CX,AX
            JMP SOUSTRAC1
            
        SOUSTRAC2:
            MOV AH,01H
            INT 21H
            CMP AL, 08H
    		JE CORRECTION
            CMP AL, 1BH
			JE FERMETURE
            CMP AL,'='
            JE SOUSTRACTION2
            CMP AL,30H
            JB SOUSTRAC2
            CMP AL,39H
            JA SOUSTRAC2
            AND AL,00001111B
            MOV BL,AL
            MOV BH,0
            MOV AX,0AH
            MUL CX
            ADD AX,BX
            MOV CX,AX
            JMP SOUSTRAC2
            
        SOUSTRAC3:
            MOV AH,01H
            INT 21H
            CMP AL, 08H
    		JE CORRECTION
            CMP AL, 1BH
			JE FERMETURE
            CMP AL,'='
            JE SOUSTRACTION3
            CMP AL,30H
            JB SOUSTRAC3
            CMP AL,39H
            JA SOUSTRAC3
            AND AL,00001111B
            MOV BL,AL
            MOV BH,0
            MOV AX,0AH
            MUL CX
            ADD AX,BX
            MOV CX,AX
            JMP SOUSTRAC3
        	
    SAISIE_DIVISION:
		MOV N1,CX
		MOV CX,0
				
    	DIVIS:
        	MOV AH,01H
        	INT 21H
        	CMP AL, 08H
    		JE CORRECTION
        	CMP AL, 1BH
			JE FERMETURE
        	CMP AL,'_'
        	JE COMPTEUR_DIVIS
        	CMP AL,'='
        	JE DIVISION
        	CMP AL,30H
        	JB DIVIS
       		CMP AL,39H
        	JA DIVIS
        	AND AL,00001111B
        	MOV BL,AL
        	MOV BH,0
        	MOV AX,0AH
        	MUL CX
        	ADD AX,BX
        	MOV CX,AX
        	JMP DIVIS
        	
    SAISIE_EUCLIDE:
		MOV N1,CX
		MOV CX,0
				
    	EUCLI:
        	MOV AH,01H
        	INT 21H
        	CMP AL, 08H
    		JE CORRECTION
	       	CMP AL, 1BH
			JE FERMETURE
        	CMP AL,'_'
        	JE COMPTEUR_EUCLI
        	CMP AL,'='
        	JE EUCLIDE
        	CMP AL,30H
        	JB EUCLI
       		CMP AL,39H
        	JA EUCLI
        	AND AL,00001111B
        	MOV BL,AL
        	MOV BH,0
        	MOV AX,0AH
        	MUL CX
        	ADD AX,BX
        	MOV CX,AX
        	JMP EUCLI

	COMPTEUR_DEB :
		INC BP
		JMP SAISIE_DEB
	COMPTEUR_MULTI :
		INC BP
		JMP MULTI
	COMPTEUR_DIVIS:
		INC BP
		JMP DIVIS
	COMPTEUR_EUCLI :
		INC BP
		JMP EUCLI

	FERMETURE :                     
		MOV AH,4CH
		INT 21H
	CORRECTION :
		JMP DEBUT

	SAISIE_FIN:
   		RET
   		
SAISIE ENDP


; ********** CALCULS **********
ADDITION:        
    ADD CX,N1
    MOV RESULTAT,CX
    CALL AFFICHAGE_RESULTAT
    JMP DEBUT
    
ADDITION_NEG:
    CMP N1,CX
    JA ADDITION_NEG1
    SUB CX,N1
    MOV RESULTAT,CX
    CALL AFFICHAGE_RESULTAT
    JMP DEBUT

ADDITION_NEG1:
    SUB N1,CX
    MOV CX,N1
    MOV RESULTAT,CX
    CALL AFFICHAGE_RESULTAT
    JMP DEBUT

SOUSTRACTION:
	CMP N1, CX
	JB SOUSTRACTION_NEGATIVE
    SUB N1, CX
    MOV CX, N1
    MOV RESULTAT,CX
    CALL AFFICHAGE_RESULTAT
    JMP DEBUT
        
    SOUSTRACTION_NEGATIVE :
    	SUB CX,N1
		MOV RESULTAT,CX
		MOV AH,09H
		LEA DX, AFFI_NEG
		INT 21H
		CALL AFFICHAGE_RESULTAT
		JMP DEBUT   
		
    SOUSTRACTION1:
        ADD CX,N1
        MOV RESULTAT,CX
        MOV AH,09H
        LEA DX, AFFI_NEG
        INT 21H
        CALL AFFICHAGE_RESULTAT
        JMP DEBUT  
        
    SOUSTRACTION2:
        CMP N1,CX
        JB SOUSTRACTION2_NEG
        SUB N1,CX
        MOV CX,N1
        MOV RESULTAT,CX
        MOV AH,09H
        LEA DX, AFFI_NEG
        INT 21H
        CALL AFFICHAGE_RESULTAT
        JMP DEBUT 
    
    SOUSTRACTION2_NEG:
        SUB CX,N1
        MOV RESULTAT,CX
        CALL AFFICHAGE_RESULTAT
        JMP DEBUT
    
    SOUSTRACTION3:
        ADD CX,N1
        MOV RESULTAT,CX
        CALL AFFICHAGE_RESULTAT
        JMP DEBUT  
        
MULTIPLICATION:
	CMP BP, 1
	JE MULTIPLICATION_NEGATIVE
	MOV AX,N1
	MUL CX
	MOV RESULTAT, AX
	CALL AFFICHAGE_RESULTAT
    JMP DEBUT
       	
       	MULTIPLICATION_NEGATIVE :
       	MOV AX, N1
       	MUL CX
       	MOV RESULTAT, AX
       	MOV AH, 09H
       	LEA DX, AFFI_NEG
       	INT 21H
       	CALL AFFICHAGE_RESULTAT
       	JMP DEBUT

PUISSANCE:
	CMP BP, 1
	JE PUISSA_NEG
	
	MOV AX, N1
	JMP PUISSA
	
	PUISSA_NEG:
		MOV AX, CX
		MOV BP, 2
		DIV BP
		MOV AX, N1
		CMP DX, 1
		JNE PUISSA
PUISSANCE_NEG:
		MUL N1
		DEC CX
		CMP CX,1
		JNE PUISSANCE_NEG
		MOV RESULTAT, AX
		MOV AH, 09H
   		LEA DX, AFFI_NEG
    	INT 21H
		CALL AFFICHAGE_RESULTAT
		JMP DEBUT

	PUISSA:	
		MUL N1
		DEC CX
		CMP CX,1
		JNE PUISSA
		MOV RESULTAT, AX
		CALL AFFICHAGE_RESULTAT
		JMP DEBUT

DIVISION:
	CMP BP, 1
	JE DIVISION_NEGATIVE
	MOV AX, N1
	DIV CX
	MOV N1, DX
	MOV RESULTAT,AX
	CALL AFFICHAGE_RESULTAT
	MOV AH, 09H
	LEA DX, VIRGULE
	INT 21H
	MOV AX, N1
	MOV BP,10
	MUL BP
	DIV CX
	MOV RESULTAT,AX
	MOV N1, DX
	CALL AFFICHAGE_RESULTAT
    MOV AX,N1
    MUL BP
    DIV CX
    MOV RESULTAT,AX
    CALL AFFICHAGE_RESULTAT
	JMP DEBUT
	       	
	    DIVISION_NEGATIVE :
       	MOV AX, N1
		DIV CX
		MOV N1, DX
		MOV RESULTAT,AX
		MOV AH, 09H
       	LEA DX, AFFI_NEG
       	INT 21H
		CALL AFFICHAGE_RESULTAT
		MOV AH, 09H
		LEA DX, VIRGULE
		INT 21H
		MOV AX, N1
		MOV BP,10
		MUL BP
		DIV CX
		MOV RESULTAT,AX
		MOV N1,DX
        CALL AFFICHAGE_RESULTAT
        MOV AX,N1
    	MUL BP
    	DIV CX
    	MOV RESULTAT,AX
		CALL AFFICHAGE_RESULTAT
		JMP DEBUT

EUCLIDE:
	CMP BP, 1
	JE EUCLIDE_NEGATIVE
	MOV AX, N1
	DIV CX
	MOV N1, DX
	MOV RESULTAT,AX
	CALL AFFICHAGE_RESULTAT
	MOV CX, N1
	MOV RESULTAT, CX
	MOV AH,09H
	LEA DX, RESTE
	INT 21H
	CALL AFFICHAGE_RESULTAT
	JMP DEBUT
	       	
	    EUCLIDE_NEGATIVE :
       	MOV AX, N1
		DIV CX
		MOV N1, DX
		MOV RESULTAT,AX
		MOV AH, 09H
       	LEA DX, AFFI_NEG
       	INT 21H
		CALL AFFICHAGE_RESULTAT
		MOV CX, N1
		MOV RESULTAT, CX
		MOV AH,09H
		LEA DX, RESTE
		INT 21H
		MOV AH, 09H
		LEA DX, AFFI_NEG
		INT 21H
		CALL AFFICHAGE_RESULTAT
		JMP DEBUT	
; ********** FIN CALCULS **********   	

; ********** PROCEDURE D'AFFICHAGE **********   	
AFFICHAGE_RESULTAT PROC

    MOV AX,RESULTAT
    MOV DX,RESULTAT+2
    MOV BX,0AH
    LEA DI,TABDEC

	CONVERSION_HEXA_DECIMAL :        
        DIV BX
        OR DL,00110000B
        MOV [DI],DL
        INC DI
        MOV DX,0
        CMP AX,0
        JNE CONVERSION_HEXA_DECIMAL        
        MOV AH,2
        
	AFFBCL:
        MOV DL,[DI]
        INT 21H
        MOV [DI], 0
        DEC DI
        CMP DI,offset TABDEC-1
        JNE AFFBCL
        
    RET
        
AFFICHAGE_RESULTAT ENDP


; ********** MAIN : DEBUT **********
DEBUT :
	SAUT_DE_LIGNE
	SAUT_DE_LIGNE
	MOV AH,09H
	LEA DX, CHAINE
	INT 21H
	
	CALL SAISIE             
     
       
; ********** DATA **********
CHAINE DB " Veuillez saisir votre operation : ", 24H
CHAINE1 DB "             ***** BIENVENUE SUR LA CALCULATRICE A MICHEL ! ***** ", 24H
CHAINE2 DB "     Presentee par Charron Jules, Guarssifi Younes et Debernardi Hippolyte ", 24H
CHAINE3 DB " Pour realiser vos petites operations, veillez a saisir les caracteres suivant : ", 24H
CHAINE4 DB " (+) : Addition ", 24H
CHAINE5 DB " (-) : Soustraction ", 24H
CHAINE6 DB " (*) : Multiplication ", 24H
CHAINE7 DB " (/) : Division ", 24H
CHAINE8 DB " (:) : Division Euclidienne ", 24H
CHAINE9 DB " (=) : Effectuer le calcul ", 24H
CHAINE10 DB " (_) : Avant le nombre pour le rendre negatif ", 24H
CHAINE11 DB " (^) : Puissance ", 24H
CHAINE12 DB " Appuyer sur ECHAP pour arreter le programme ", 24H
CHAINE13 DB " Appuyer sur BACKSPACE pour refaire la saisie ", 24H


AFFI_NEG DB " -", 24H
RESTE DB " reste", 24H
VIRGULE DB ".", 24H
BUFFER DB 80, ?, 80 DUP ('$')   
N1 DW ?
RESULTAT DW ?
TABDEC DB 8 DUP (?) 
    
    CSEG ENDS
    END MAIN