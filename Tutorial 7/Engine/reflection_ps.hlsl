////////////////////////////////////////////////////////////////////////////////
// Filename: reflection.ps
////////////////////////////////////////////////////////////////////////////////


/////////////
// GLOBALS //
/////////////
Texture2D shaderTexture;
SamplerState SampleType;


Texture2D reflectionTexture;


//////////////
// TYPEDEFS //
//////////////
struct PixelInputType
{
    float4 position : SV_POSITION;
    float2 tex : TEXCOORD0;
    float4 reflectionPosition : TEXCOORD1;
};


////////////////////////////////////////////////////////////////////////////////
// Pixel Shader
////////////////////////////////////////////////////////////////////////////////
float4 ReflectionPixelShader(PixelInputType input) : SV_TARGET
{
    float4 textureColor;
    float2 reflectTexCoord;
    float4 reflectionColor;
    float4 color;


    // Sample the texture pixel at this location.
    textureColor = shaderTexture.Sample(SampleType, input.tex);


// Calculate the projected reflection texture coordinates.
reflectTexCoord.x = input.reflectionPosition.x / input.reflectionPosition.w / 2.0f + 0.5f;
reflectTexCoord.y = -input.reflectionPosition.y / input.reflectionPosition.w / 2.0f + 0.5f;


// Sample the texture pixel from the reflection texture using the projected texture coordinates.
reflectionColor = reflectionTexture.Sample(SampleType, reflectTexCoord);


// Do a linear interpolation between the two textures for a blend effect.
color = lerp(textureColor, reflectionColor, 0.15f);

return color;
}