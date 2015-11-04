Shader "Custom/Lab-10"  {
	Properties{
		_Color ("Color Tint", Color) = (1,1,1,1)
		_SpecColor("Specular Color", Color) = (1,1,1,1)
		_Shininess("Shininess", float) = 10
	}
	
	SubShader{
		Pass{
			CGPROGRAM
			#pragma vertex vertexFunction
			#pragma fragment fragmentFunction
			
			//usr defined variables
			uniform float4 _Color;
			uniform float4 _SpecColor;
			uniform float _Shininess;
			
			//unity defined variables
			uniform float4 _LightColor0;
			
			//input struct
			struct inputStruct
			{
				float4 vertexPos : POSITION;
				float3 vertexNormal : NORMAL;
			};
			
			//output struct
			struct outputStruct
			{
				float4 pixelPos : SV_POSITION;
				float4 pixelCol : COLOR;
			};
			
			//vertex program
			outputStruct vertexFunction(inputStruct input)
			{
				outputStruct toReturn;
				
				float3 lightDirection;
				float attenuation = 1.0;
				
				lightDirection = normalize(_WorldSpaceLightPos0.xyz);
				
				float3 diffuseReflection = attenuation * _LightColor0.xyz * max(0.0, dot(normalDirection, lightDirection));
				
				float3 normalDirection = normalize(mul(float4(input.vertexNormal,0.0), _World2Object).xyz);
				
				float3 viewDirection = normalize(float3(float4(_WorldSpaceCameraPos.xyz, 1.0) - mul(_Object2World, input.vertexPos).xyz));
				
				toReturn.pixelPos = mul(UNITY_MATRIX_MVP, input.vertexPos);
				toReturn.pixelCol = float4(viewDirection, 1.0);
				
				return toReturn;
			}
			
			//fragment program
			float4 fragmentFunction(outputStruct input) : COLOR
			{
				return input.pixelCol;
			}
			
			ENDCG
		}
	}
	//Fallback
	//Fallback "Diffuse"
}