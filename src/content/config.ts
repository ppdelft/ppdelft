import { defineCollection, z } from "astro:content";

export const collections = {
  gallery: defineCollection({
    type: "content",
    schema: z.object({
      title: z.string(),
      description: z.string(),
      date: z.date(),
      image: z.string(),
      dimensions: z.string().optional(),
      technique: z.string().optional(),
      sold: z.boolean().default(false),
      featured: z.boolean().default(false),
    }),
  }),
};
