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
				
				float3 normalDirection : TEXCOORD0;
				float4 pixelWorldPos : TEXCOORD1;
			};
			
			//vertex program
			outputStruct vertexFunction(inputStruct input)
			{
				outputStruct toReturn;
				
				//float3 lightDirection;
				//float attenuation = 1.0;
				
				//lightDirection = normalize(_WorldSpaceLightPos0.xyz);
				
				
				toReturn.normalDirection = normalize(mul(float4(input.vertexNormal,0.0), _World2Object).xyz);
				//float3 diffuseReflection = attenuation * _LightColor0.xyz * max(0.0, dot(normalDirection, lightDirection));
				//float3 specularReflection = reflect(-lightDirection, normalDirection);
				//float3 viewDirection = normalize(float3(float4(_WorldSpaceCameraPos.xyz, 1.0) - mul(_Object2World, input.vertexPos).xyz));
				toReturn.pixelWorldPos = (_WorldSpaceCameraPos.xyz, 1.0);
				
				//specularReflection = dot(specularReflection, viewDirection);
				//specularReflection = max(0.0, specularReflection);
				//specularReflection = pow(max(0.0, specularReflection), _Shininess);
				//specularReflection = max(0.0, dot(normalDirection, lightDirection)) * specularReflection;
				
				//float3 finalLight = specularReflection + diffuseReflection + UNITY_LIGHTMODEL_AMBIENT;
				
				toReturn.pixelPos = mul(UNITY_MATRIX_MVP, input.vertexPos);
				//toReturn.pixelCol = float4(viewDirection, 1.0);
				//toReturn.pixelCol = float4(specularReflection, 1.0);
				//toReturn.pixelCol = float4(finalLight * _Color, 1.0);
				
				return toReturn;
			}
			
			//fragment program
			float4 fragmentFunction(outputStruct input) : COLOR
			{
				float3 lightDirection;
				float attenuation = 1.0;
			
				lightDirection = normalize(_WorldSpaceLightPos0.xyz);
			
				//float3 normalDirection = normalize(mul(float4(input.vertexNormal,0.0), _World2Object).xyz);
				float3 diffuseReflection = attenuation * _LightColor0.xyz * max(0.0, dot(input.normalDirection, lightDirection));
				float3 specularReflection = reflect(-lightDirection, input.normalDirection);
				//float3 viewDirection = normalize(float3(float4(_WorldSpaceCameraPos.xyz, 1.0) - mul(_Object2World, input.vertexPos).xyz));
			
				specularReflection = dot(specularReflection, input.pixelWorldPos);
				specularReflection = max(0.0, specularReflection);
				specularReflection = pow(max(0.0, specularReflection), _Shininess);
				specularReflection = max(0.0, dot(input.normalDirection, lightDirection)) * specularReflection;
				
				float3 finalLight = specularReflection + diffuseReflection + UNITY_LIGHTMODEL_AMBIENT;
			
				//input.pixelCol = float4(input.pixelWorldPos, 1.0);
				input.pixelCol = float4(specularReflection, 1.0);
				input.pixelCol = float4(finalLight * _Color, 1.0);
				return input.pixelCol;
			}
			
			ENDCG
		}
	}
	//Fallback
	//Fallback "Diffuse"
}