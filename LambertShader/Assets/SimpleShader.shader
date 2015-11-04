Shader "SimpleShader" {
	Properties
	{
		_Color("Flibberty Ghibbets",Color) = (0.0,0.0,0.0,1.0)
	}
	SubShader
	{
		Pass
		{
			CGPROGRAM
				//pragmas
				#pragma vertex vertexFunction
				#pragma fragment fragmentFunction
				
				//rawr
				//user defined variables
				uniform float4 _Color;
				//float, float2, float3, float4
				//half, half2, half3, half4
				//fixed, fixed2, fixed3, fixed4
				
				//structs
				struct vertexInput
				{
					float4 vertexPosition : POSITION;	//get the vertex position
				};
				
				//SEMANTICS
					//COLOR - the color of the vertex (float4)
					//POSITION - the position of the vertex
					//SV_POSITION - output position of vertex, dx11, output ONLY (float4)
					//NORMAL - normal of the vertex (float4)
					//TANGENT - tangent direction (float4)
					//TEXCOORD0 - the first UV map (float4)
					//TEXCOORD1 - the second uv map (float4)
					//TEXCOORD2-??? - Empty semantics for data transfer
					
				struct vertOutput
				{
					float4 position : SV_POSITION;
				};
				
				//vertex function
				vertOutput vertexFunction(vertexInput input)
				{
					vertOutput toReturn;
					
					//REQUIRED FOR ALL VERTEX FUNCTIONS
					toReturn.position = mul(UNITY_MATRIX_MVP, input.vertexPosition);
						//UNITY_MATRIX_MVP is a float4x4 
						//View Projection Matrix
						//Multiply each float4 of the matrix by the x,y,z of vertex position
							//float4x4 myMatix
							//myMatrix[0] = UNITY_MATRIX_MVP[0] * input.vertexPosition.vertex
							
					return toReturn;
				}
				
				//fragmnet function, aka Pixel Shader
				float4 fragmentFunction(vertOutput output) : COLOR
				{
					return _Color;
				}
			
			ENDCG
		}
	}
	
	//Fallback - Commented out during shader development
	//Fallback "Diffuse"
}